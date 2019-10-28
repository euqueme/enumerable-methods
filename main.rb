# frozen_string_literal: true

# Maru's Enumerables
module Enumerable
  def my_each
    size.times do |i|
      yield self[i]
    end
  end

  def my_each_with_index
    size.times do |i|
      yield self[i], i
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

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
end
