class Application < ActiveRecord::Base
  attr_accessible :complete, :number, :user_id

  validates_presence_of :number, :user_id
  validates_uniqueness_of :number

  belongs_to :user
  has_many :steps, dependent: :destroy

  before_create :validate_application_number
  after_create :update_current_step

  scope :incomplete, where(complete: false)

  def current_step
    steps.last
  end

  def status_update_date
    current_step.created_at.strftime('%m/%d/%Y')
  end

  def update_current_step
    unless complete
      step = get_current_step_from_uscis
      status = Status.find_by_name(step[:status])
      logger.info "Status not found: '#{step[:status]}'." if status.nil?

      update_attributes(complete: true) if step[:complete] == "true"

      unless status.nil?
        if current_step.nil? or current_step.status != status
          steps.create!(status_id: status.id, description: step[:description], more_info: step[:general_description])
        end
      end
    end
    current_step
  end

  def self.update_all_statuses
    incomplete.each do |app|
      StatusUpdateWorker.perform_async(app.id)
    end
  end

  private

    def get_current_step_from_uscis
      step = Rails.cache.fetch("step#{number}", :expires_in => 1.minute) do
        USCISStatus.check(number).first
      end
    end

    def validate_application_number
      step = get_current_step_from_uscis
      if step[:status].include?("invalid")
        Rails.cache.delete("step#{number}")
        errors.add(:base, 'Invalid application number')
        return false
      else
        return true
      end
    end
end
