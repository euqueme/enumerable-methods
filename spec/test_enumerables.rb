# spec/test_enumerables.rb

# frozen_string_literal: true

require '../main.rb'

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'returns an enumerable when no block is given' do
      expect([1, 2, 3].my_each.class).to eq([1, 2, 3].each.class)
    end

    it 'returns the same as each method when a block is given' do
      # rubocop:disable Metrics/LineLength
      expect([1, 2, 3].my_each { |element| puts "result: #{element}" }).to eq([1, 2, 3].each { |element| puts "result: #{element}" })
      # rubocop:enable Metrics/LineLength
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerable when no block is given' do
      expect([1, 2, 3].my_each_with_index.class).to eq([1, 2, 3].each_with_index.class)
    end

    it 'returns index and items when a block is given' do
      # rubocop:disable Metrics/LineLength
      expect([1, 2, 3].my_each_with_index { |element, index| puts "result: #{element}, #{index}" }).to eq([1, 2, 3].each_with_index { |element, index| puts "result: #{element}, #{index}" })
      # rubocop:enable Metrics/LineLength
    end
  end
  
  describe '#my_select' do
    it 'returns an enumerable when no block is given' do
      expect([1, 2, 3].my_select.class).to eq([1, 2, 3].select.class)
    end

    it 'returns an array when a block is given' do
      # rubocop:disable Metrics/LineLength
      expect([1, 2, 3].my_select { |element| "result: #{element}" }).to eq([1, 2, 3].each_with_index { |element| "result: #{element}" })
      # rubocop:enable Metrics/LineLength
    end
  end
end
