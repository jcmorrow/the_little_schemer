require "spec_helper"
require "tokenizer"
require "parser"

describe Parser do
  describe "#parse" do
    it "can parse a null token" do
      tokens = Tokenizer.new("()").tokens

      expect(Parser.new(tokens).tree).to eq(NullNode.instance)
    end

    it "can parse an atom" do
      tokens = Tokenizer.new("atom").tokens

      expect(Parser.new(tokens).tree).to eq(AtomNode.new("atom"))
    end

    it "can parse a list with one item" do
      tokens = Tokenizer.new("(atom)").tokens

      expect(Parser.new(tokens).tree).to eq(
        ListNode.new(
          AtomNode.new("atom"),
          NullNode.instance,
        ),
      )
    end

    it "can parse a list with more than one item" do
      tokens = Tokenizer.new("(atoms are)").tokens

      expect(Parser.new(tokens).tree).to eq(
        ListNode.new(
          AtomNode.new("atoms"),
          ListNode.new(
            AtomNode.new("are"),
            NullNode.instance,
          ),
        ),
      )
    end

    it "can parse a nested list with more than one item" do
      tokens = Tokenizer.new("(atoms (are))").tokens

      expect(Parser.new(tokens).tree).to eq(
        ListNode.new(
          AtomNode.new("atoms"),
          ListNode.new(
            ListNode.new(
              AtomNode.new("are"),
              NullNode.instance,
            ),
            NullNode.instance,
          ),
        ),
      )
    end

    it "can parse a function call" do
      tokens = Tokenizer.new("(car (atom))").tokens

      expect(Parser.new(tokens).tree).to eq(
        CarNode.new(
          ListNode.new(
            AtomNode.new("atom"),
            NullNode.instance,
          ),
        ),
      )
    end
  end
end
