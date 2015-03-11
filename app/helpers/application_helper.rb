  module ApplicationHelper
  def shuffle_hash
    Hash[self.to_a.sample(self.length)]
  end
  def shuffle_hash!
    self.replace(self.shuffle)
  end

  def sortable(column, name = nil)
    name ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to name, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def find_questions(uid)
    @substep = Substep.find(uid)
    if @substep.typex == 'quiz'
      return Quiz.find(@substep.sid).id
    end
  end

  def find_quiz(qid)
    return Quiz.find(qid)
  end

  def hash_revert
    r = Hash.new {|h,k| h[k] = []}
    each {|k,v| r[v] << k}
    r
  end

end
