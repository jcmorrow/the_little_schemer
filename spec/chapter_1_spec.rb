require "spec_helper"
require "interpreter"

describe "(atom? l)" do
  it "interprets words as atoms" do
    pending
    expect(Interpreter.interpret("(atom? atom)")).to be true
  end
end

describe "#tokenize" do
  it "can tokenize parens" do
    expect(Interpreter.new("()").tokens).to eq(
      [
        Token.new(:oparen, "("),
        Token.new(:cparen, ")"),
      ],
    )
  end

  it "can tokenize atoms" do
    expect(Interpreter.new("atom").tokens).to eq([Token.new(:atom, "atom")])
    expect(Interpreter.new("1492").tokens).to eq([Token.new(:atom, "1492")])
  end

  it "can tokenize a define call" do
    expect(Interpreter.new("(define foo)").tokens).to eq(
      [
        Token.new(:oparen, "("),
        Token.new(:define, "define"),
        Token.new(:atom, "foo"),
        Token.new(:cparen, ")"),
      ],
    )
  end

  it "can tokenize the defintion of `atom?`" do
    scheme = <<~SCH
      (define atom?
        (lambda (x)
          (and (not (pair? x)) (not (null? x)))))
    SCH
    expect(Interpreter.new(scheme).tokens.first(10)).to eq(
      [
        Token.new(:oparen, "("),
        Token.new(:define, "define"),
        Token.new(:atom, "atom?"),
        Token.new(:oparen, "("),
        Token.new(:atom, "lambda"),
        Token.new(:oparen, "("),
        Token.new(:atom, "x"),
        Token.new(:cparen, ")"),
        Token.new(:oparen, "("),
        Token.new(:atom, "and"),
      ],
    )
  end
end
