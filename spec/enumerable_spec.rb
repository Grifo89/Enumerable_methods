require_relative '../enumerable_methods'

describe Enumerable do
  let(:array) {[1,2,3,4]}

  describe "#my_each" do
    context "When block is passed" do
      it "Does what block describes" do
        output = []
        array.my_each {|element| output << element}
        expect(output).to eql(array)
      end
    end
    context "When block is not passed" do
      it "Returns Enumerable object" do
        expect(array.my_each).to be_a(Enumerable)
      end
    end
  end
end
