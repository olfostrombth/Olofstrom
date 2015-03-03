class Examination < ActiveRecord::Base
	include PublicActivity::Model
  belongs_to :category
end
