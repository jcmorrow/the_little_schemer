require "irb"

class Interpreter
  TOKEN_TYPES = [
    [:oparen, /\A(\()/],
    [:cparen, /\A(\))/],
    [:define, /\A(define)/],
    [:atom, /\A([^()\s]+)/],
  ].freeze

  def initialize(scheme)
    @scheme = scheme.strip
    @tokens = []
  end

  def tokens
    @_tokens ||= tokenize
  end

  def interpret
    # so first we tokenize right?
    # This means we pull tokens off until we have no more expression left
    tokenize
  end

  def tokenize
    until @scheme.empty?
      @tokens << tokenize_one_token
    end
    @tokens
  end

  def tokenize_one_token
    TOKEN_TYPES.each do |token_type|
      if @scheme =~ token_type[1]
        token = Token.new(token_type[0], $1)
        @scheme = @scheme.slice($1.length, @scheme.length).strip
        return token
      end
    end

    raise "Cannot tokenize #{@scheme}"
  end
end

Token = Struct.new(:type, :value)
