class Quiz < ActiveRecord::Base
	include PublicActivity::Model
  belongs_to :step
  has_many :questions
end
