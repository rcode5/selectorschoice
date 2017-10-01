# frozen_string_literal: true

class RandomString
  LETTERS_PLUS_SPACE = ('a'..'z').to_a + ('A'..'Z').to_a

  def self.generate(len = 8)
    numchars = LETTERS_PLUS_SPACE.length
    (0..len).map { LETTERS_PLUS_SPACE[rand(numchars)] }.join
  end
end
