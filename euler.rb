# Euler problem #1: If we list all the natural numbers below 10 that are multiples of 3 or 5, 
# we get 3, 5, 6 and 9. The sum of these multiples is 23.

# Find the sum of all the multiples of 3 or 5 below 1000.
def find_multiples num
  multiples = Array.new
  (1...num).each do |i|
    if( (i % 3 == 0) || (i % 5 == 0) )
      multiples << i      
    end
  end
  return multiples
end

# this just takes an array of numbers and adds up their sorry asses
def find_sum nums
  sum = 0
  (0...nums.length).each do |i|
    sum += nums[i]
  end
  return sum
end

# got the right answer
def euler_1 num
  multiples = Array.new
  multiples = find_multiples(num)
  return find_sum(multiples)
end

# Euler problem #2: Each new term in the Fibonacci sequence is 
# generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

# By considering the terms in the Fibonacci sequence whose values do not exceed four million, find 
# the sum of the even-valued terms.

# Find the fibonacci sequence up to any number
def find_fibs num
  fibs = Array.new
  first = 0
  second = 1

  (0...num).each do |i|
    i = first + second
    first = second
    second = i
    fibs << i if i <= num
  end
  return fibs
end

# take an array of numbers and return the even numbers
# afterwards use helper method find_sum to get the answer
def find_evens nums
  evens = Array.new
  (0...nums.length).each do |i|
    if (nums[i] % 2) == 0      
      evens << nums[i]
    end
  end
  return evens
end

# get 4613732 as answer
def euler_2 
  nums = Array.new
  nums = find_evens(find_fibs(4000000))
  return find_sum(nums)
end

# Euler problem #3: The prime factors of 13195 are 5, 7, 13 and 29.
#What is the largest prime factor of the number 600851475143 ?

# first find the factors
def is_factor num
  results = Array.new
  (1..num).each do |i|
    results << i if num % i == 0
  end
  results     
end

# this is the best method yet for finding a prime
def is_prime? num
  (2...num).each { |i| return false if (num % i == 0) } 
  return true
end

# now solve problem #3
# this method works for smaller sample data but times out for big number
def euler_3 num
  factors = is_factor(num)
  primes = Array.new
  (0...factors.length).each do |i|
    if is_prime?(factors[i])
      primes << factors[i]
    end
  end
  return primes.last
end

# better solution to #3 that returns within a reasonable timeframe
# returns 6857 
def other_euler_3 num
  #n = 600_851_475_143
  primes = []
  product_sum = 1
  x = 2 # 2 is the first prime number
   
  # big time saver seems to be determining the factors and primes in one go
  while product_sum < num
    if num % x == 0 && is_prime?(x) 
      primes << x
      product_sum *= x
    end
    x += 1
  end  
  return primes.last
end

# Euler problem #4: A palindromic number reads the same both ways. 
# The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

# first find a way of sorting through numbers to find a palindrome
# takes a number, makes an array of it, then tests equality with the reverse array
def is_palindrome? num
  return true if (num.to_s == num.to_s.reverse)
  return false
end

# next multiply 3-digit numbers and test for a palindrome
# it makes sense to start with the largest numbers and work down
# then return as soon as a palindrome is found
# answer is 906609
def euler_4
  # separate variable needed to get the largest answer as first palindrome found isn't the largest
  biggie = 0 

  # two loops needed as with just one the largest isn't found
  999.downto(100) do |i|
    999.downto(100) do |j|
      prod = i * j
      if is_palindrome?(prod) && biggie < prod
        biggie = prod
      end
    end
  end
  return biggie
end

# Euler problem #5: 2520 is the smallest number that can be divided by each of the numbers 
#from 1 to 10 without any remainder.

#What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
# Answer: 232792560
def euler_5
  answer = 0
  badDivsorFound = false
  j = 2520

  while answer == 0
    x = 11
    while x <= 20
      if is_divisible?(x,j)
        answer = j
      else
        answer = 0
        break
      end
      x+=1
    end

    j += 20
  end
  puts answer.to_s

end


# helper method for problem #5
def is_divisible? (i, j)
  if ( (j % i) == 0 )
    return true
  else  
    return false
  end
end

# Euler problem #6: The sum of the squares of the first ten natural numbers is,

# 1^2 + 2^2 + ... + 10^2 = 385
# The square of the sum of the first ten natural numbers is (1 + 2 + ... + 10)2 = 552 = 3025

# Hence the difference between the sum of the squares of the first ten natural numbers and the 
# square of the sum is 3025  385 = 2640.

# Find the difference between the sum of the squares of the first one hundred natural numbers 
# and the square of the sum.

# first the squares of n natural numbers
def find_squares_sum(top, bottom)
  squares = Array.new
  (top..bottom).each do |i|
    squares << (i * i)
    puts i
  end
  find_sum(squares)
end

def find_sum_squares(top, bottom)
  nums = Array.new
  (top..bottom).each do |i|
     nums << i
   end
   find_sum(nums) * find_sum(nums)
end

# got the right answer first try! 25164150
def euler_6(top, bottom)
  find_squares_sum(top, bottom) - find_sum_squares(top, bottom)
end

# Euler problem #7: By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, 
# we can see that the 6th prime is 13.
# What is the 10 001st prime number?

# given a big-ass number return the nth prime, 
# works if you start at 1, answer is 104743
def euler_7 (num_start, num_end, ind)
  count = 0
  (num_start..num_end).each do |i| 
    count += 1 if is_prime?(i)
    if count == (ind + 1)
      return i
    end
  end
end

# Euler problem #8: Find the greatest product of five consecutive digits in the 
# 1000-digit number. (number omitted for sanity reasons)
# got 40824, the right answer
def euler_8 
  old_prod = 0
  new_prod = 0
  
  # First get the big-ass number and make it into an Array
  # each line will be an element in the new Array
  data = File.new("number_series").to_a
  # then break that into Arrays so you can loop through all the digits
  data_line = []

  (0..data.length).each do |i|
    data_line = data[i].to_s.chomp.split("")
    (0..data_line.length).each do |j|
      old_prod = (data_line[j].to_i * data_line[j+1].to_i * data_line[j+2].to_i * data_line[j+3].to_i * data_line[j+4].to_i)
      if old_prod >= new_prod
        new_prod = old_prod
      end
    end   
  end
  puts "here's the answer: " + new_prod.to_s
end

# Euler problem #9: A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

# a2 + b2 = c2
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

# first find the one pythagorean triplet
# got 200, 375, 425
def find_pyth_triplet num
  (1...num).each do |i|
    (1...num).each do |j|
      (1...num).each do |k|
        if ((i*i) + (j*j) == (k*k)) && i < j && j < k
          if i + j + k == num && i < j && j < k
            puts "here's a: " + i.to_s
            puts "here's b: " + j.to_s
            puts "here's c: " + k.to_s
          end
        end
      end
    end
  end
end

# get 31875000, the right answer
def euler_9( a, b, c)
  return a * b * c
end


# Euler problem #10: The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

# Find the sum of all the primes below two million.
# use helper is_prime?(#)
# got 142913828922, the right answer, but it took several hours to execute
def euler_10( upto )
  sum = 0
  (2...upto).each do |i|
    # this is a rather haphazard way of speeding things up a bit
    # in retrospect a lot more if statements may have been even better
    if (i % 10 != 0) && (i % 20 != 0) && (i % 30 != 0) && (i % 50 != 0)
      sum += i if is_prime?(i)
    end
  end
  return sum
end

# Euler problem #11: What is the greatest product of four adjacent numbers in the 
# same direction (up, down, left, right, or diagonally) in the 20x20 grid?
def make_matrix filename
  data = File.new(filename).to_a
 
  matrix = (0...data.length).map{[]}
  # make an Array of Arrays & map each element to int
  (0...data.length).each do |i|
    matrix[i] = data[i].to_s.split(' ').map { |num| num.to_i  }
  end
  #puts matrix.inspect
  return matrix
end

# use filename 'number_matrix'
# Got 70600674
def euler_11 filename
  matrix = (0...20).map{[]}
  matrix = make_matrix(filename)
  horiz_prod = 0 
  vert_prod = 0 
  diag_prod1 = 0 
  diag_prod2 = 0
  answers = []

  (0...matrix.length-4).each do |i|
    (0...matrix.length-4).each do |j|
      # first check horizontally
      horiz_prod = matrix[i][j] * matrix[i][j+1] * matrix[i][j+2] * matrix[i][j+3]
      answers << horiz_prod
      # then vertically
      vert_prod = matrix[i][j] * matrix[i+1][j] * matrix[i+2][j] * matrix[i+3][j]
      answers << vert_prod
      # then diagonally
      diag_prod1 = matrix[i][j] * matrix[i+1][j+1] * matrix[i+2][j+2] * matrix[i+3][j+3]
      #answers << diag_prod1
      diag_prod2 = matrix[i+3][j] * matrix[i+2][j+1] * matrix[i+1][j+2] * matrix[i][j+3]
      answers << diag_prod2
    end
  end
  puts answers.max
end

# Euler problem 12: The sequence of triangle numbers is generated by adding the natural numbers. So the 7th triangle number 
# would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first ten terms would be:

# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

# Let us list the factors of the first seven triangle numbers:

# 1: 1
# 3: 1,3
# 6: 1,2,3,6
# 10: 1,2,5,10
# 15: 1,3,5,15
# 21: 1,3,7,21
# 28: 1,2,4,7,14,28
# We can see that 28 is the first triangle number to have over five divisors.

#What is the value of the first triangle number to have over five hundred divisors?


# Euler problem 13: Work out the first ten digits of the sum of the following one-hundred 50-digit numbers.
# number saved to file 'big_ass_number'
# got 5537376230
def euler_13
 data = File.new("big_ass_number").to_a
 data_line = []
 sum = 0 
 digits = []

 (0..data.length).each do |i|
  sum += data[i].to_i
  end
  digits = sum.to_s
  puts digits.slice(0...10)
 end
  


# Euler problem #16: 2^15 = 32768. The sum of the digits is 3 + 2 + 7 + 6 + 8 = 26
# What is the sum of the digits of the number 2^1000?

# returns an int array from the nth power of a number
def make_array( power, num )
  str_nums = []
  nums = []
  newnum = num**power
  str_nums = newnum.to_s.split('')
  (0...str_nums.length).each do |i|
    nums << str_nums[i].to_i 
  end
  return nums
end

# got 1366, the right answer
def euler_16( power, num )
  nums = []
  nums = make_array( power, num )
  return find_sum(nums)
end
