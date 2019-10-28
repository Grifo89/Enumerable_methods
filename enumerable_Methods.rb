module Enumerable
  # my_each
  def my_each
    if block_given?
      i = 0
      while i < self.size
        yield(self[i])
        i += 1
      end
      self
    end
    self.to_enum
  end
  # my_each_with_index
  def my_each_with_index
    if block_given?
      i = 0
      while i < self.size
        yield(self[i], i)
        i += 1
      end
      self
    end
    self.to_enum
  end
  # my_select
  def my_select
    if block_given?
      arr = []
      self.my_each do |a|
        if yield(a)
          arr.push(a)
        end
      end
      arr
    end
    self.to_enum
  end
  # my_all
  def my_all?
    if block_given?
      i = 0
      while i < self.size
        unless yield(self[i])
          return false
        end
        i += 1
      end
      true
    end
    self.to_enum
  end
  # my_any
  def my_any?
    if block_given?
      result = false
      self.my_each {|a| result = true if yield(a)}
      return result
    end
    self.to_enum
  end
  #my_none
  def my_none?
    if block_given?
      result = false
      self.my_each {|a| result = true unless yield(a)}
      return result
    end
    self.to_enum
  end
  # my_count
  def my_count(arg = nil)
    count = 0
    if block_given?
      self.my_each {|a| count += 1 if yield(a)}
    elsif arg
      self.my_each {|a| count += 1 if a == arg}
    else
      count = self.size
    end
    count
  end
  # my_map
  def my_map
    if block_given?
      arr = []
      self.to_a.my_each {|a|  arr.push(yield(a)) }
      return arr
    end
    self.to_enum
  end
  # my_inject
  
end



# [1,33,5,7,2,4,6].my_each {|a| puts a * 2}
# print "------------------------- \n"
# [1,33,5,7,2,4,6].my_each_with_index {|a, i| puts "number #{a} and index #{i}"}
#
# puts [1,33,5,7,2,4,6].my_select { |num| num.even? }
# puts %w[an be cat].none? { |word| word.length >= 4 }
# [].any?
# puts [1,2,3,3,2].my_count(6)
puts (1..4).my_map {|i| i*i}
