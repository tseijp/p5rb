require 'matrix'
require './perlin/curve'
require './perlin/gradient_table'
require './perlin/noise'

# [ref](https://github.com/junegunn/perlin_noise)


def _noise_1d(start_num, end_num, interval, seed) 
  output = []
  n1d = Perlin::Noise.new 1
  start_num.step(end_num, interval.to_f) do |x|
    output.push( n1d[ x/(start_num-end_num).abs ] )
  end
  return output
end

def _noise_2d(start_arr, end_arr, interval_arr, seed)
  output = []
  n2d = Perlin::Noise.new 2
  start_arr[1].step(end_arr[1], interval_arr[1].to_f) do |x|
    arr = []
    start_arr[0].step(end_arr[0], interval_arr[0].to_f) do |y|
      arr.push( n2d[x/(start_arr[0]-end_arr[0]).abs, y/(start_arr[1]-end_arr[1]).abs] )
    end
    output.push(arr)
  end
  return output
end
def noise(p1, p2, interval=1, seed=1234)
  interval_arr = [interval, interval]
  if interval.instance_of?(Array)
    interval_arr = [interval[0], interval[1]]
  end
  
  if p1.instance_of?(Array) and p2.instance_of?(Array)
    return _noise_2d( [p1[0], p2[0]], [p1[1], p2[1]], interval_arr, seed)
  else
    return _noise_1d( p1, p2, interval, seed)
  end
end

def arr2p(arr2d)
  points = []
  j = 0
  arr2d.each do |arr1d|
    i = 0
    arr1d.each do |x|
      points.push( [i, j, x] )
      i = i+1 
    end
    j = j+1
  end
  return points
end

