module Enumerable
  # my_each
  def my_each
    i = 0
    while i < self.size
      yield(self[i])
      i += 1
    end
    self
  end
  # my_each_with_index
  def my_each_with_index
    i = 0
    while i < self.size
      yield(self[i], i)
      i += 1
    end
    self
  end
  # my_select
  def my_select
    arr = []
    self.my_each do |a|
      if yield(a)
        arr.push(a)
      end
    end
    arr
  end
end


[1,33,5,7,2,4,6].my_each {|a| puts a * 2}
print "------------------------- \n"
[1,33,5,7,2,4,6].my_each_with_index {|a, i| puts "number #{a} and index #{i}"}

puts [1,33,5,7,2,4,6].my_select { |num| num.even? }