class Application < ActiveRecord::Base
  attr_accessible :complete, :number, :user_id

  validates_presence_of :number, :user_id
  validates_uniqueness_of :number

  belongs_to :user
  has_many :steps, dependent: :destroy

  before_create :validate_application_number
  after_create :update_current_step

  default_scope order("complete ASC")

  def current_step
    steps.last
  end

  def update_current_step
    step = get_current_step_from_uscis
    status = Status.find_by_name(step[:status])
    if current_step.nil? or current_step.status_id != status.id
       steps.create!(status_id: status.id, description: step[:description], more_info: step[:general_description])
    end
    current_step
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
