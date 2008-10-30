class String
  def camelize
    self.gsub(/([A-Z])/, '_\1').gsub(/^_/, '').downcase
  end
  
  def camelize!
    replace(camelize)
  end
end