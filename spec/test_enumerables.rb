# spec/test_enumerables.rb

# frozen_string_literal: true

require '../main.rb'

RSpec.describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:ar_with_strings) { [1, '2', 3] }
  let(:arr_truthy) { [nil, true, 99] }
  let(:arr_empty) { [] }
  let(:arr_string) { %w[ant bear cat] }
  let(:arr_numeric) { [1, 2i, 3.14] }
  describe '#my_each' do
    it 'returns an enumerable when no block is given' do
      expect(array.my_each.class).to eq(array.each.class)
    end

    it 'returns the same as each method when a block is given' do
      # rubocop:disable Metrics/LineLength
      expect(array.my_each { |element| puts "result: #{element}" }).to eq([1, 2, 3].each { |element| puts "result: #{element}" })
      # rubocop:enable Metrics/LineLength
    end

    it 'raises an ArgumentError when an argument is given' do
      expect { array.my_each('arg') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerable when no block is given' do
      expect(array.my_each_with_index.class).to eq(array.each_with_index.class)
    end

    it 'returns index and items when a block is given' do
      # rubocop:disable Metrics/LineLength
      expect(array.my_each_with_index { |element, index| puts "result: #{element}, #{index}" }).to eq(array.each_with_index { |element, index| puts "result: #{element}, #{index}" })
      # rubocop:enable Metrics/LineLength
    end

    it 'raises an ArgumentError when an argument is given' do
      expect { array.my_each_with_index('arg') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_select' do
    it 'returns an enumerable when no block is given' do
      expect(array.my_select.class).to eq(array.select.class)
    end

    it 'returns an array when a block is given' do
      # rubocop:disable Metrics/LineLength
      expect(ar_with_strings.my_select { |element| element.is_a?(String) }).to eq(ar_with_strings.select { |element| element.is_a?(String) })
      # rubocop:enable Metrics/LineLength
    end

    it 'raises an ArgumentError when an argument is given' do
      expect { array.my_select('arg') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_all?' do
    # rubocop:disable Metrics/LineLength
    it 'evaluate each item inside the array. When no block is given and if arguments also are not given, returns `true` if all the elementes are truthy != (nil, false)' do
      # rubocop:enable Metrics/LineLength
      expect(arr_truthy.my_all?).to eq(false)
    end

    it 'When an array is empty and block is not given, my_all? method will returs true' do
      expect(arr_empty.my_all?).to eq(true)
    end

    it 'raises an ArgumentError when more than one arguments are given' do
      expect { array.my_all?(String, 1) }.to raise_error(ArgumentError)
    end

    it 'When block is given, my_all? method will evaluate all the elements and will return a boolean' do
      expect(arr_string.my_all? { |word| word.length >= 3 }).to eq(true)
    end

    it 'When a RegEx is passed as an argument, it will evaluate all the elements and will return a boolean' do
      expect(arr_string.my_all?(/t/)).to eq(false)
    end

    it 'When a Class is passed as an argument, it will evaluate all the elements and will return a boolean' do
      expect(arr_numeric.my_all?(Numeric)).to eq(true)
    end
  end
end
