require "spec_helper"
require "parser"
require "generator"

describe "#generate" do
  it "can generate shallow lists" do
    ast = ListNode.new(
      AtomNode.new(:a),
      NullNode.instance,
    )

    expect(Generator.new(ast).generate).
      to eq("List.new('a', NullSet.new)")
  end

  it "can generate nested lists" do
    ast = ListNode.new(
      AtomNode.new(:a),
      ListNode.new(
        AtomNode.new(:b),
        NullNode.instance,
      ),
    )

    expect(Generator.new(ast).generate).
      to eq("List.new('a', List.new('b', NullSet.new))")
  end

  it "can generate nested lists" do
    pending "CarNodes"

    ast = CarNode.new(
      ListNode.new(
        AtomNode.new(:a),
        ListNode.new(
          AtomNode.new(:b),
          NullNode.instance,
        ),
      ),
    )

    expect(Generator.new(ast).generate).
      to eq("List.new('a', List.new('b', NullSet.new)).car")
  end
end
