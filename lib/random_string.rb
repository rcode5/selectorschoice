class RandomString
  LETTERS_PLUS_SPACE =  []
  ('a'..'z').each {|ltr| LETTERS_PLUS_SPACE << ltr}
  ('A'..'Z').each {|ltr| LETTERS_PLUS_SPACE << ltr}

  def self.generate(len=8)
    numchars = LETTERS_PLUS_SPACE.length
    (0..len).map{ LETTERS_PLUS_SPACE[rand(numchars)] }.join
  end
end

