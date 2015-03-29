class UserExamination < ActiveRecord::Base
  belongs_to :examination
  belongs_to :user
end
