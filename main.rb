# frozen_string_literal: true

# rubocop:disable Metrics/ModuleLength

# Maru's Enumerables
module Enumerable
  def my_each
    if block_given?
      size.times do |i|
        is_a?(Range) ? yield(min + i) : yield(self[i])
      end
    else
      self
    end
  end

  def my_each_with_index
    if block_given?
      size.times do |i|
        is_a?(Range) ? yield(min + i, i) : yield(self[i], i)
      end
    else
      self
    end
  end

  def my_select
    if block_given?
      output = []
      my_each { |element| yield(element) ? output.push(element) : nil }
      output
    else
      self
    end
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_all?(arg = nil)
    output = true
    my_each do |element|
      if output
        if block_given?
          output = false unless yield(element)
        elsif arg.is_a?(Class) || arg.is_a?(Regexp)
          output = element.is_a?(arg) unless arg.is_a?(Regexp)
          output = element.match?(arg) if arg.is_a?(Regexp)
        elsif arg
          output = true if element == arg
        else
          output = false unless element
        end
      end
    end
    output
  end

  def my_any?(arg = nil, &block)
    output = false
    my_each do |element|
      if block_given?
        output ||= block.call(element) unless output
      elsif arg.is_a?(Class) || arg.is_a?(Regexp)
        output ||= element.is_a?(arg) unless arg.is_a?(Regexp)
        output ||= element.match?(arg) if arg.is_a?(Regexp)
      elsif arg
        output = true if element == arg
      elsif element || output
        output = true
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

  def my_inject(arg = nil, arg2 = nil)
    output = is_a?(Range) ? min : self[0]
    if block_given?
      my_each_with_index { |ele, i| output = yield(output, ele) if i.positive? }
      output = yield(output, arg) if arg
    elsif arg.is_a?(Symbol) || arg.is_a?(String)
      my_each_with_index { |ele, i| output = output.send(arg, ele) if i.positive? }
    elsif arg2.is_a?(Symbol) || arg2.is_a?(String)
      my_each_with_index { |ele, i| output = output.send(arg2, ele) if i.positive? }
      output = output.send(arg2, arg)
    end
    output
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  def my_map(proc = nil)
    output = []
    if block_given?
      my_each { |element| output.push(yield(element)) } unless proc
      my_each { |element| output << proc.call(element) } if proc
    elsif proc
      my_each { |element| output << proc.call(element) }
    else
      return self
    end
    output
  end
end

# rubocop:enable Metrics/ModuleLength
def multiply_els(arg = [])
  arg.my_inject { |multiply, n| multiply * n }
end

puts multiply_els([2, 4, 5])

a = [18, 22, 5, 6]
my_proc = proc { |num| num > 10 }
puts a.my_map(my_proc) { |num| num > 10 }
