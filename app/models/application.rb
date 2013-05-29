class Application < ActiveRecord::Base
  attr_accessible :complete, :number, :user_id

  validates_presence_of :number, :user_id
  validates_uniqueness_of :number

  belongs_to :user
  has_many :steps, dependent: :destroy

  before_create :validate_application_number
  after_create :update_current_step

  default_scope order("complete ASC")
  scope :incomplete, where(complete: false)

  def current_step
    steps.last
  end

  def status_update_date
    current_step.created_at.strftime('%m/%d/%Y')
  end

  def update_current_step
    step = get_current_step_from_uscis
    status = Status.find_by_name(step[:status])
    if current_step.nil? or current_step.status_id != status.id
       steps.create!(status_id: status.id, description: step[:description], more_info: step[:general_description])
    end
    current_step
  end

  def self.update_all_statuses
    incomplete.each do |app|
      app.update_current_step
    end
  end

  private

    def get_current_step_from_uscis
      unless complete
        USCISStatus.check(number).first
      end
    end

    def validate_application_number
      step = get_current_step_from_uscis
      if step[:status].include?("invalid")
        errors.add(:base, 'Invalid application number')
        return false
      else
        return true
      end
    end
end
