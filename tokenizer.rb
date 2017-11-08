class Tokenizer
  TOKEN_TYPES = [
    [:null, /\A(\(\))/],
    [:oparen, /\A(\()/],
    [:cparen, /\A(\))/],
    [:car, /\A(car)/],
    [:cdr, /\A(cdr)/],
    [:define, /\A(define)/],
    [:lambda, /\A(lambda)/],
    [:atom, /\A([^()\s]+)/],
  ].freeze

  def initialize(scheme)
    @scheme = scheme
  end

  def tokens
    @_tokens ||= tokenize
  end

  def tokenize
    [].tap do |tokens|
      until @scheme.empty?
        tokens << tokenize_one_token
      end
    end
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
