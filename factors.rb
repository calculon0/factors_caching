input = [10, 5, 2, 20, 10]

cache = {}

def load_cache(cache)
  file = File.open('cache', 'r')
  file.readlines.each do |line|
    entry = line.split('=')
    cache[entry[0]] = entry[1]
  end
end

def print_factors(input, cache)
  if cache[input.to_s]
    return cache[input.to_s]
  end
  output = ""
  output += '{'
  input.each do |i|
    result = []
    input.each do |j|
      if j != i && factor(i, j)
        result.push j
      end
    end
    output += i.to_s + ': ' + result.to_s + ', '
  end
  output[output.length-1] == ' ' ? output.chomp!(', ') : nil
  output += '}'
  cache[input] = output
  file = File.open('cache', 'a')
  file.puts "#{input}=#{output}"
  output
end

def factor(num, potential_factor)
  num % potential_factor == 0
end

load_cache(cache)
puts print_factors(input, cache)