require "spec_helper"
require "interpreter"

describe "(car (atom))" do
  it "can interpret a car statement" do
    pending "CarNodes"

    expect(interpret("(car (atom))")).to eq("atom")
  end

  it "can interpret nested lists" do
    expect(interpret("(a (b c))")).to eq("(a ((b (c ())) ()))")
  end

  def interpret(scheme)
    Interpreter.new(scheme).interpret.to_s
  end
end
