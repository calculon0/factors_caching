input = [2, 10, 5, 10, 20]

cache = {}

def load_cache(cache)
  file = File.open('cache', 'r')
  file.readlines.each do |line|
    entry = line.split('=')
    value = entry[1].split('|')
    cache[entry[0]] = [value[0], value[1]]
  end
end

def add_to_cache(key, factors, reverse_factors, cache)
  cache[key] = [factors, reverse_factors]
  file = File.open('cache', 'a')
  file.puts "#{key}=#{factors}|#{reverse_factors}"
end

def check_cache(input, cache, factors)
  if cache[input.to_s]
    return factors ? cache[input.to_s][0] : cache[input.to_s][1]
  end
  factors_output = ""
  factors_output += '{'
  reverse_output = factors_output
  input.each do |i|
    factors_result = []
    reverse_result = []
    input.each do |j|
      if j != i && factor(i, j)
        factors_result.push j
      end
      if j != i && factor(j, i)
        reverse_result.push j
      end
    end
    factors_output += i.to_s + ': ' + factors_result.to_s + ', '
    reverse_output += i.to_s + ': ' + reverse_result.to_s + ', '
  end
  factors_output[factors_output.length-1] == ' ' ? factors_output.chomp!(', ') : nil
  reverse_output[reverse_output.length-1] == ' ' ? reverse_output.chomp!(', ') : nil
  factors_output += '}'
  reverse_output += '}'
  add_to_cache(input, factors_output, reverse_output, cache)
  factors ? factors_output : reverse_output
end

def print_factors(input, cache)
  input.sort!
  output = check_cache(input, cache, true)
end

def print_reverse_factors(input, cache)
  input.sort!
  output = check_cache(input, cache, false)
end

def factor(num, potential_factor)
  num % potential_factor == 0
end

load_cache(cache)
puts "factors: "
puts print_factors(input, cache)
puts "reverse factors: "
puts print_reverse_factors(input, cache)