class Category < ActiveRecord::Base
  has_many :steps
  has_one :examination
  has_many :comments
end
