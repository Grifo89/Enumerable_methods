# frozen_string_literal: true

require_relative '../enumerable_methods'

describe Enumerable do
  let(:array) { [1, 2, 3, 4] }

  describe '#my_each' do
    context 'When block is passed' do
      it 'Does what block describes' do
        output = []
        array.my_each { |element| output << element }
        expect(output).to eql(array)
      end
    end
    context 'When block is not passed' do
      it 'Returns Enumerable object' do
        expect(array.my_each).to be_a(Enumerable)
      end
    end
  end

  describe '#my_each_with_index' do
    context 'When block is passed' do
      it 'Does what block describes' do
        output = []
        array.my_each_with_index { |element, i| output << [element, i] }
        expect(output).to eql([[1, 0], [2, 1], [3, 2], [4, 3]])
      end
    end
    context 'When block is not passed' do
      it 'Returns Enumerable object' do
        expect(array.my_each_with_index).to be_a(Enumerable)
      end
    end
  end

  describe '#my_all?' do
    context 'When block is passed' do
      it 'Checks the block condition for the whole array' do
        output = array.my_all? { |a| a < 10 }
        expect(output).to eql(true)
      end
    end
    context 'When regex is passed as argument' do
      it 'Checks if the patter matches through all elements' do
        output = %w[ant bear cat].all?(/t/)
        expect(output).to eql(false)
      end
    end
    context 'When a class is passed' do
      it "Checks if the class matches with the array items' class" do
        output = array.my_all?(Numeric)
        expect(output).to eql(true)
      end
    end
    context 'When my_all? is applied to an empty array' do
      it "It's suppoused to yield true" do
        expect([].my_all?).to eql(true)
      end
    end
    context 'When my_all? is applied to an array which has nil or false as item' do
      it "It's suppoused to yield false" do
        expect([nil, true, 99].my_all?).to eql(false)
      end
    end
    context "When my_all? is applied to an array which doesn't have nil or false as item" do
      it "It's suppoused to yield true" do
        expect([[], true, 99].my_all?).to eql(true)
      end
    end
  end

  describe '#my_any?' do
    context 'When a block is passed' do
      it 'Checks if any of the element meets the condition and yields true if some element does' do
        expect(array.any? { |a| a < 2 }).to eql(true)
      end
    end
    context 'When an array with at least one item different than false or nil is passed' do
      it 'It returns true' do
        expect([false, nil, nil, 7].my_any?).to eql(true)
      end
    end
    context 'When a regex patern or string is passed' do
      it 'It returns true if any item meets that patern' do
        expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
      end
      it 'It returns true if the string match an item' do
        expect(%w[ant bear cat].my_any?('cat')).to eql(true)
      end
    end
  end

  describe '#my_none?' do
    context 'When no block or argument is given' do
      it 'returns true only if none of the collection members is true' do
        expect([true, 4, 's'].my_none?).to eql(false)
      end
    end
    context 'When argument is passed' do
      it 'When argument is a class, returns true if none of the collection member is of such class' do
        expect([true, 's', 3].my_none?(String)).to eql(false)
      end
      it 'when a pattern other than Regex or a Class is given returns true only if none of the collection matches the pattern.' do
        expect([6, 7, 3].my_none?(6)).to eql(false)
      end
    end
  end

  describe '#my_map' do
    context 'when a method is applied to a range' do
      it "It returns an array with the range's members" do
        expect((1..4).my_map { |a| a * 1 }).to eql(array)
      end
    end
  end
end
