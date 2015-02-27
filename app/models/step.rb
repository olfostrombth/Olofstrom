class Step < ActiveRecord::Base
	include PublicActivity::Model
  belongs_to :category
  has_many :quizzes
  has_many :assignments
  has_many :guides
  has_many :videos
end
