class Video < ActiveRecord::Base
  belongs_to :step

  attr_accessor :uid
end
