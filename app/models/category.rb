class Category < ActiveRecord::Base
  has_many :steps
  has_many :examinations
  has_many :comments
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  #Normalized category name for use in DB and other places
  def self.normalize_cat(cat)
    cat.downcase.gsub(/['’]/, '').gsub(/ /, '-').gsub(/[àáâãäå]/, 'a').gsub(/[ö]/, 'o')
  end
end
