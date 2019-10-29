# frozen_string_literal: true

module Enumerable
  # my_each
  def my_each
    if block_given?
      i = 0
      while i < size
        yield(self[i])
        i += 1
      end
      self
    end
    to_enum
  end

  # my_each_with_index
  def my_each_with_index
    if block_given?
      i = 0
      while i < size
        yield(self[i], i)
        i += 1
      end
      self
    end
    to_enum
  end

  # my_select
  def my_select
    if block_given?
      arr = []
      my_each do |a|
        arr.push(a) if yield(a)
      end
      arr
    end
    to_enum
  end

  # my_all
  def my_all?
    if block_given?
      i = 0
      while i < size
        return false unless yield(self[i])

        i += 1
      end
      true
    end
    to_enum
  end

  # my_any
  def my_any?
    if block_given?
      result = false
      my_each { |a| result = true if yield(a) }
      return result
    end
    to_enum
  end

  # my_none
  def my_none?
    if block_given?
      result = false
      my_each { |a| result = true unless yield(a) }
      return result
    end
    to_enum
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
    if block_given?
      arr = []
      to_a.my_each { |a| arr.push(yield(a)) }
      return arr
    end
    to_enum
  end

  # my_inject
  def my_inject(*args)
    acumulator = !args.empty? ? args[0] : to_a[0]
    to_a.drop(!args.empty? ? 0 : 1).my_each { |a| acumulator = yield(acumulator, a) }
    acumulator
  end

  # my_map with proc
  def my_map_proc(block)
    arr = []
    to_a.my_each { |a| arr.push(block.call(a)) }
    arr
  end

  # my_map with block and proc
  def my_map_proc_bloc(block = nil)
    arr = []
    if block
      to_a.my_each { |a| arr.push(block.call(a)) }
    else
      to_a.my_each { |a| arr.push(yield(a)) }
    end
    arr
  end
end

# multiply_els
def multiply_els(arr)
  arr.my_inject { |acum, i| acum * i }
end

# [1,33,5,7,2,4,6].my_each {|a| puts a * 2}
# print "------------------------- \n"
# [1,33,5,7,2,4,6].my_each_with_index {|a, i| puts "number #{a} and index #{i}"}
#
# puts [1,33,5,7,2,4,6].my_select { |num| num.even? }
# puts %w[an be cat].none? { |word| word.length >= 4 }
# [].any?
# puts [1,2,3,3,2].my_count(6)
# puts (1..4).my_map {|i| i*i}
# puts [1,2,3].my_inject(:+)
# puts (5..10).my_inject(2) { |sum, n| sum + n }
# longest = %w[ cat sheep bear ].my_inject do |memo, word|
#    memo.length > word.length ? memo : word
# end
# puts longest
# proc1 = Proc.new {|i| i * 2}
# puts [1,2,3,4].my_map_proc(proc1)
# puts multiply_els([2,4,5])
