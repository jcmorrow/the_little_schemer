require "generator"
require "parser"
require "tokenizer"

class Interpreter
  def initialize(scheme)
    @scheme = scheme.strip
    @tokens = Tokenizer.new(@scheme).tokens
    @ast = Parser.new(@tokens).parse
    @transpiled_code = Generator.new(@ast).generate
  end

  def interpret
    eval(@transpiled_code)
  end
end
