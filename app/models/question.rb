class Question < ActiveRecord::Base
	include PublicActivity::Model
  belongs_to :quiz
end
