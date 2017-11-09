RUNTIME = <<~COD
  List = Struct.new(:car, :cdr)
COD

eval(RUNTIME)

class Generator
  def initialize(ast)
    @ast = ast
    @code = ""
  end

  def generate
    node = @ast[0]
    case node
    when AtomNode
      @code << "'#{node.value}'"
    when ListNode
      @code << generate_list(node)
    when CarNode
      @code << "#{generate_list(node.list)}.car"
    else
      raise "Cannot generate code for #{@ast}"
    end
  end

  def generate_list(node, exprs = "")
    if node == NullNode.instance
      "[]"
    elsif node.car.class == AtomNode
      exprs << "List.new('#{node.car.value}', #{generate_list(node.cdr, exprs)})"
    end
  end
end
