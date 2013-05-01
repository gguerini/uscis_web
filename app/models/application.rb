class Application < ActiveRecord::Base
  attr_accessible :complete, :number, :user_id

  validates_presence_of :number, :user_id
  validates_uniqueness_of :number


  belongs_to :user
end
