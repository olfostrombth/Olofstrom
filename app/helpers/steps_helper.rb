module StepsHelper
  def shuffle_hash
    Hash[self.to_a.sample(self.length)]
  end
  def shuffle_hash!
    self.replace(self.shuffle)
  end
end
