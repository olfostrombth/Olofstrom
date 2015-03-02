class Substep < ActiveRecord::Base
  belongs_to :Step
  include RankedModel
  ranks :row_order


  #Substep type,id,placement,step_id
  #What do I want to do<<
  #I want to get steps <<


end
