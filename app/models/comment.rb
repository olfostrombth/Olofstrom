class Comment < ActiveRecord::Base
	include PublicActivity::Model
  belongs_to :category
  belongs_to :user
  include RankedModel
  ranks :row_order
end
