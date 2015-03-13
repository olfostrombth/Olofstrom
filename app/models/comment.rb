class Comment < ActiveRecord::Base
	include PublicActivity::Model
  belongs_to :category
  belongs_to :user
end
