# frozen_string_literal: true

# Maru's Enumerables
module Enumerable
  def my_each
    size.times do |i|
      is_a?(Range) ? yield(min + i) : yield(self[i])
    end
  end

  def my_each_with_index
    size.times do |i|
      is_a?(Range) ? yield(min + i, i) : yield(self[i], i)
    end
  end

  def my_select
    output = []
    my_each { |element| yield(element) ? output.push(element) : nil }
    output
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    output = true
    my_each do |element|
      if output
        if block_given?
          output = false unless yield(element)
        elsif arg
          output = element.is_a?(arg) unless arg.is_a?(Regexp)
          output = element.match?(arg) if arg.is_a?(Regexp)
        else
          output = false unless element
        end
      end
    end
    output
  end

  def my_any?(arg = nil)
    output = false
    my_each do |element|
      if output == false
        if block_given?
          output = yield(element)
        elsif arg
          output = element.is_a?(arg) unless arg.is_a?(Regexp)
          output = element.match?(arg) if arg.is_a?(Regexp)
        else
          output = true unless element
        end
      end
    end
    output
  end

  def my_none?(arg = nil)
    output = true
    my_each do |element|
      if output
        if block_given?
          output = false if yield(element)
        elsif arg
          output = !element.is_a?(arg) unless arg.is_a?(Regexp)
          output = !element.match?(arg) if arg.is_a?(Regexp)
        elsif element
          output = false
        end
      end
    end
    output
  end

  def my_count(arg = nil)
    counter = 0
    my_each do |element|
      if block_given?
        counter += 1 if yield(element)
      elsif arg
        counter += 1 if element == arg
        counter += 1 if arg.is_a?(Regexp) && element.match?(arg)
      else
        counter += 1
      end
    end
    counter
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
  def my_map(enumerable = nil, &proc)
    output = []
    if block_given?
      my_each { |element| output.push(yield(element)) }
    elsif enumerable && proc
      enumerable.my_each { |element| output << proc.call(element) }
    end
    output
  end

  def my_inject(arg = nil)
    output = is_a?(Range) ? min : self[0]
    my_each_with_index { |ele, i| output = yield(output, ele) if i.positive? }
    output = yield(output, arg) if arg
    output
  end
end

def multiply_els(arg = [])
  arg.my_inject { |multiply, n| multiply * n }
end

puts multiply_els([2, 4, 5])

a = [18, 22, 5, 6]
my_proc = proc { |num| num > 10 }
puts a.my_map(a, &my_proc)
