require "spec_helper"
require "interpreter"

describe "(car (atom))" do
  it "can interpret a car statement" do
    expect(Interpreter.new("(car (atom))").interpret).to eq("atom")
  end
end
