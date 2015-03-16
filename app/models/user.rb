require 'csv'

class User < ActiveRecord::Base
  has_many :comments



  searchkick autocomplete: ['name'],
             suggest: ['name']

  def self.from_omniauth(auth)
    array = {}
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.admin = true
      comp = User.where({name:auth.info.name}).first
      compl = JSON.parse(comp.completion) if comp
      user.completion = if compl then compl.to_json else array.to_json end
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end


  def self.import(file)
    array = {}
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = find_by_id(row["id"]) || new
      attributes = row.to_hash
      user.email = attributes['E-postadress']
      user.name = attributes['Förnamn'] + " " + attributes['Efternamn']
      user.completion = array.to_json
      user.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path)
      when ".xls" then Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
