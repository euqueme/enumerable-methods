# spec/test_enumerables.rb

# frozen_string_literal: true

require_relative '../main.rb'

RSpec.describe Enumerable do
  let(:array) { [1, 2, 3, 2] }
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
      expect(array.my_each { |element| puts "result: #{element}" }).to eq(array.each { |element| puts "result: #{element}" })
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

    # rubocop:disable Metrics/LineLength
    it 'When an argument (not a Class or RegEx) is passed, it evaluates the elements and returns true when one of them it´s an instance of the Class' do
      # rubocop:enable Metrics/LineLength
      expect(arr_numeric.my_all?(2)).to eq(false)
    end

    # rubocop:disable Metrics/LineLength
    it 'When an argument and a block are given, it ignores the block and returns true if one of the elements meets the condition in the argument' do
      # rubocop:enable Metrics/LineLength
      expect(arr_string.my_all?(Numeric) { |word| word.length >= 3 }).to eq(false)
    end
  end

  describe '#my_any?' do
    it 'When no block and no argument are given, returns `true` when one of the elementes is truthy != (nil, false)' do
      expect(arr_truthy.my_any?).to eq(true)
    end

    it 'When an array is empty and no block is given, will return false' do
      expect(arr_empty.my_any?).to eq(false)
    end

    it 'raises an ArgumentError when more than one arguments are given' do
      expect { array.my_any?(String, 1) }.to raise_error(ArgumentError)
    end

    it 'When block is given, it evaluates the elements and returns true when one of them meets the condition' do
      expect(arr_string.my_any? { |word| word.length >= 3 }).to eq(true)
    end

    # rubocop:disable Metrics/LineLength
    it 'When a RegEx is passed as an argument, it evaluates the elements and returns true when one of them matches the RegEx' do
      # rubocop:enable Metrics/LineLength
      expect(arr_string.my_any?(/t/)).to eq(true)
    end

    # rubocop:disable Metrics/LineLength
    it 'When a Class is passed as an argument, it evaluates the elements and returns true when one of them it´s an instance of the Class' do
      # rubocop:enable Metrics/LineLength
      expect(arr_numeric.my_any?(Numeric)).to eq(true)
    end

    # rubocop:disable Metrics/LineLength
    it 'When an argument (not a Class or RegEx) is passed, it evaluates the elements and returns true when one of them it´s an instance of the Class' do
      # rubocop:enable Metrics/LineLength
      expect(arr_numeric.my_any?(2)).to eq(false)
    end

    # rubocop:disable Metrics/LineLength
    it 'When an argument and a block are given, it ignores the block and returns true if one of the elements meets the condition in the argument' do
      # rubocop:enable Metrics/LineLength
      expect(arr_string.my_any?(Numeric) { |word| word.length >= 3 }).to eq(false)
    end
  end

  describe '#my_none?' do
    it 'When no block and no argument are given, returns `false` when one of the elementes is truthy != (nil, false)' do
      expect(arr_truthy.my_none?).to eq(false)
    end

    it 'When an array is empty and no block is given, will return `true`' do
      expect(arr_empty.my_none?).to eq(true)
    end

    it 'raises an ArgumentError when more than one arguments are given' do
      expect { array.my_none?(String, 1) }.to raise_error(ArgumentError)
    end

    it 'When block is given, it evaluates the elements and returns `false` when one of them meets the condition' do
      expect(arr_string.my_none? { |word| word.length >= 3 }).to eq(false)
    end

    # rubocop:disable Metrics/LineLength
    it 'When a RegEx is passed as an argument, it evaluates the elements and returns `false` when one of them matches the RegEx' do
      # rubocop:enable Metrics/LineLength
      expect(arr_string.my_none?(/t/)).to eq(false)
    end

    # rubocop:disable Metrics/LineLength
    it 'When a Class is passed as an argument, it evaluates the elements and returns `false` when one of them it´s an instance of the Class' do
      # rubocop:enable Metrics/LineLength
      expect(arr_numeric.my_none?(Numeric)).to eq(false)
    end

    # rubocop:disable Metrics/LineLength
    it 'When an argument (not a Class or RegEx) is passed, it evaluates the elements and returns `false` when one of them it´s an instance of the Class' do
      # rubocop:enable Metrics/LineLength
      expect(arr_numeric.my_none?(2)).to eq(true)
    end

    # rubocop:disable Metrics/LineLength
    it 'When an argument and a block are given, it ignores the block and returns `false` if one of the elements meets the condition in the argument' do
      # rubocop:enable Metrics/LineLength
      expect(arr_string.my_none?(Numeric) { |word| word.length >= 3 }).to eq(true)
    end

    it 'validates that my_none is the negation of my_any method' do
      # rubocop:disable Metrics/LineLength
      expect(arr_string.my_none?(Numeric) { |word| word.length >= 3 }).to eq(!arr_string.my_any?(Numeric) { |word| word.length >= 3 })
      # rubocop:enable Metrics/LineLength
    end
  end

  describe '#my_count' do
    it 'When no block and no argument are give returns the number of elements' do
      expect(array.my_count).to eq(4)
    end

    it 'When an array is empty and no block is given, will return 0' do
      expect(arr_empty.my_count).to eq(0)
    end

    it 'raises an ArgumentError when more than one arguments are given' do
      expect { array.my_count(String, 1) }.to raise_error(ArgumentError)
    end

    it 'When block is given, it evaluates the elements and returns the elements when them meets the condition' do
      expect(array.my_count { |x| (x % 2).zero? }).to eq(2)
    end

    # rubocop:disable Metrics/LineLength
    it 'When an argument (not a Class or RegEx) is passed, it evaluates the elements and returns the elements that meets the conditions' do
      # rubocop:enable Metrics/LineLength
      expect(array.my_count(2)).to eq(2)
    end
  end

  describe '#my_inject' do
    # rubocop:disable Metrics/LineLength
    it 'When block is given, it passes each element as an argument of the method in the block and stores it in the memo variable, returns the result of memo at the end' do
      # rubocop:enable Metrics/LineLength
      expect(array.my_inject { |memo, element| memo / element }).to eq(0)
    end

    # rubocop:disable Metrics/LineLength
    it 'When two argument are given, it passes each element and the first argument as an argument of the method provided in the second argument and returns the result ' do
      # rubocop:enable Metrics/LineLength
      expect(array.my_inject(2, :+) { |memo, element| memo / element }).to eq(10)
    end

    # rubocop:disable Metrics/LineLength
    it 'When block and an argument are given, it passes each element and the argument as an argument of the method in the block and stores it in the memo variable, returns the result of memo at the end' do
      # rubocop:enable Metrics/LineLength
      expect(array.my_inject { |memo, element| memo * element }).to eq(12)
    end

    # rubocop:disable Metrics/LineLength
    it 'When block and two argument are given, it ignores the block and it passes each element and the argument as an argument of the method provided in the second argument and returns the result ' do
      # rubocop:enable Metrics/LineLength
      expect(array.my_inject(2, :+) { |memo, element| memo / element }).to eq(10)
    end

    it 'When an array is empty and no block is given, will return nil' do
      expect(arr_empty.my_inject).to eq(nil)
    end

    it 'raises an ArgumentError when more than two arguments are given' do
      expect { array.my_inject(1, :*, 2) }.to raise_error(ArgumentError)
    end

    it 'raises a NoMethodError when the second argument is not a method' do
      expect { array.my_inject(:*, 'Numeric') }.to raise_error(NoMethodError)
    end

    it 'raises a NoMethodError when none of the two arguments is a method' do
      expect { array.my_inject(Numeric, 'RegEx') }.to raise_error(NoMethodError)
    end

    # rubocop:disable Metrics/LineLength
    it 'raises an TypeError when the second argument is a method but the first argument is not a valid argument for that method' do
      # rubocop:enable Metrics/LineLength
      expect { array.my_inject(String, :*) }.to raise_error(TypeError)
    end

    it 'raises an NoMethodError when block is given but the method in the block is not an operator' do
      expect { array.my_inject { |memo, element| memo > element } }.to raise_error(NoMethodError)
    end
  end

  describe '#my_map' do
    # rubocop:disable Metrics/LineLength
    it 'When block is given, it passes each element as an argument of the method in the block and returns a new array' do
      # rubocop:enable Metrics/LineLength
      expect(array.my_map { |element| element + 2 }).to eq([3, 4, 5, 4])
    end

    it 'arguments are given, it will raise ArgumentError' do
      expect { array.my_map(1, :*, 2) }.to raise_error(ArgumentError)
    end

    it 'When block and a proc are given, it will take as a priority the proc' do
      proc_ex = proc { |element| element + 2 }
      expect(array.my_map(proc_ex) { |element| element + 1 }).to eq([3, 4, 5, 4])
    end

    it 'When an array is empty and no block is given, will return an Enumerator' do
      expect(arr_empty.my_map.class).to eq(Enumerator)
    end

    it 'When proc is given, it will return an array with the proc rules' do
      proc_ex = proc { |element| element + 2 }
      expect(array.my_map(proc_ex)).to eq([3, 4, 5, 4])
    end

    it 'When block is given, it will return an array with the block rules' do
      expect(array.my_map { |element| element + 2 }).to eq([3, 4, 5, 4])
    end
  end
end
