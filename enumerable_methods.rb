# frozen_string_literal: true

module Enumerable # rubocop:disable Metrics/ModuleLength
  # my_each
  def my_each
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  # my_each_with_index
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  # my_select
  def my_select
    return to_enum unless block_given?

    arr = []
    my_each do |a|
      arr.push(a) if yield(a)
    end
    arr
  end

  # my_all
  def my_all?(arg = nil) # rubocop:disable Layout/TrailingWhitespace
    if block_given?
      my_each { |a| return false unless yield(a) }
      return true
    end
    if arg.class == Regexp
      my_each { |a| return false unless a.match(arg) }
      return true
    elsif arg.class == Class
      my_each { |a| return false unless a.class == arg || a.class.superclass == arg }
      return true
    elsif arg.nil? && !block_given? && !empty?
      return false
    end
    true
  end

  # my_any
  def my_any?(arg = nil)
    if block_given?
      my_each { |a| return true if yield(a) }
      return false
    end
    if arg.class == Regexp
      my_each { |a| return true if a.match(arg) }
      return false
    elsif arg.class == Class
      my_each { |a| return true if a.class == arg || a.class.superclass == arg }
      return false
    elsif arg.nil? && !block_given? && !empty?
      return true
    end
    false
  end

  # my_none
  def my_none?(arg = nil)
    if block_given?
      my_each { |a| return false if yield(a) }
      return true
    end
    if arg.class == Regexp
      my_each { |a| return false if a.match(arg) }
      return true
    elsif arg.class == Class
      my_each { |a| return true unless a.class == arg || !a.class.superclass == arg }
      return true
    elsif arg.nil? && !block_given? && !empty?
      return true
    end
    true
  end

  # my_count
  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |a| count += 1 if yield(a) }
    elsif arg
      my_each { |a| count += 1 if a == arg }
    else
      count = size
    end
    count
  end

  # my_map
  def my_map
    return to_enum unless block_given?

    arr = []
    to_a.my_each { |a| arr.push(yield(a)) }
    arr
  end

  # my_inject
  def my_inject(accumulator = nil, operation = nil, &block)
    if operation.nil? && block.nil?
      operation = accumulator
      accumulator = nil
    end

    block = case operation
            when Symbol
              ->(acc, value) { acc.send(operation, value) }
            when nil
              block
            end

    if accumulator.nil?
      ignore_first = true
      accumulator = first
    end

    index = 0

    each do |element|
      accumulator = block.call(accumulator, element) unless ignore_first && index.zero?
      index += 1
    end
    accumulator
  end

  # my_map with proc
  def my_map_proc(&block)
    arr = []
    to_a.my_each { |a| arr.push(block.call(a)) }
    arr
  end

  # my_map with block and proc
  def my_map_proc_bloc(&block)
    arr = []
    to_a.my_each { |a| arr.push(block.call(a)) }
    arr
  end
end

# multiply_els
def multiply_els(arr)
  arr.my_inject { |acum, i| acum * i }
end

puts [1,2,3,4,5].my_none?(String)
