class Step < ActiveRecord::Base
  attr_accessible :application_id, :description, :more_info, :status_id

  validates :application_id, :status_id, presence: true

  belongs_to :application
  belongs_to :status
end
