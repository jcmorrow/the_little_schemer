require "singleton"
require "irb"

class Parser
  attr_reader :tree

  def initialize(tokens)
    @tokens = tokens
    @tree = []
    parse
  end

  def parse
    until @tokens.empty?
      @tree << parse_one_token
    end
  end

  def parse_one_token
    case @tokens.first.type
    when :null
      consume(:null)
      NullNode.instance
    when :atom
      AtomNode.new(consume(:atom).value)
    when :oparen
      parse_list
    else
      raise "Cannot parse #{@tokens.first.inspect}"
    end
  end

  def consume(token_type)
    token = @tokens.first
    if token.type == token_type
      @tokens.shift
    else
      raise "Expected #{token_type} but got #{token.type}: #{token.value}"
    end
  end

  # should we have something like "parse_maybe_list?" <- also is this
  # parse_s_expr?

  def parse_list
    consume(:oparen)
    list = parse_inner_list
    consume(:cparen)
    list
  end

  def parse_inner_list
    next_token = @tokens.first
    case next_token.type
    when :atom
      ListNode.new(AtomNode.new(consume(:atom).value), parse_inner_list)
    when :oparen
      ListNode.new(parse_list, parse_inner_list)
    when :cparen
      NullNode.instance
    end
  end
end

class NullNode
  include Singleton
end
AtomNode = Struct.new(:value)
ListNode = Struct.new(:car, :cdr)
