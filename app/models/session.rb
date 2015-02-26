class Session < ActiveRecord::Base
  searchkick autocomplete: ['name'],
  					suggest: ['name']
end