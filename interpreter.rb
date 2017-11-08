require "irb"

class Interpreter
  def initialize(scheme)
    @scheme = scheme.strip
    @tokens = Tokenizer.tokens
  end

  def interpret
    # so first we tokenize right?
    # This means we pull tokens off until we have no more expression left
  end
end
