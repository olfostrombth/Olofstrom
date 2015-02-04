class Category < ActiveRecord::Base
  has_many :steps
  has_many :examinations
  has_many :comments
end
