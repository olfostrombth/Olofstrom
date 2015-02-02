class Step < ActiveRecord::Base
  belongs_to :category
  has_many :quizzes
  has_many :assignments
  has_many :guides
  has_many :videos
end
