class Video < ActiveRecord::Base
	include PublicActivity::Model
  belongs_to :step
end
