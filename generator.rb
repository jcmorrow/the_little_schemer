class NullSet
  def to_s
    "()"
  end
end

List = Struct.new(:car, :cdr) do
  def to_s
    "(" + [car, cdr].join(' ') + ")"
  end
end


class Generator
  def initialize(ast)
    @ast = ast
    @code = ""
  end

  def generate
    node = @ast
    case node
    when AtomNode
      @code << "'#{node.value}'"
    when ListNode
      @code << generate_list(node)
    else
      raise "Cannot generate code for #{@ast.class}"
    end
  end

  def generate_list(node)
    if node.is_a? NullNode
      "NullSet.new"
    elsif node.car.is_a?(AtomNode)
      "List.new('#{node.car.value}', #{generate_list(node.cdr)})"
    elsif node.car.is_a?(ListNode)
      <<~CAR
        List.new(
          #{generate_list(node.car)}, #{generate_list(node.cdr)}
        ),
      CAR
    else
      raise "Expected Atom, List, or Null, got: #{node.car.class}"
    end
  end
end
