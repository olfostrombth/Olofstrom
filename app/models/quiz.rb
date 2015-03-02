class Quiz < ActiveRecord::Base
  belongs_to :step
  has_many :questions

  attr_accessor :uid
end
