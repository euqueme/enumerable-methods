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
end
