require "spec_helper"
require "tokenizer"

describe "#tokenize" do
  it "can tokenize null" do
    expect(Tokenizer.new("(").tokens).to eq(
      [Token.new(:oparen, "(")],
    )
    expect(Tokenizer.new(")").tokens).to eq(
      [Token.new(:cparen, ")")],
    )
    expect(Tokenizer.new("()").tokens).to eq(
      [Token.new(:null, "()")],
    )
  end

  it "can tokenize atoms" do
    expect(Tokenizer.new("atom").tokens).to eq([Token.new(:atom, "atom")])
    expect(Tokenizer.new("1492").tokens).to eq([Token.new(:atom, "1492")])
  end

  it "can tokenize a define call" do
    expect(Tokenizer.new("(define foo)").tokens).to eq(
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
    expect(Tokenizer.new(scheme).tokens.first(10)).to eq(
      [
        Token.new(:oparen, "("),
        Token.new(:define, "define"),
        Token.new(:atom, "atom?"),
        Token.new(:oparen, "("),
        Token.new(:lambda, "lambda"),
        Token.new(:oparen, "("),
        Token.new(:atom, "x"),
        Token.new(:cparen, ")"),
        Token.new(:oparen, "("),
        Token.new(:atom, "and"),
      ],
    )
  end
end
