require './p5'

p5 = P5.new()
p5.size(512*4, 288*4)

num_x = 16
num_y = 9
r = 32

n = noise([0,16],[0,9])

for j in 0..num_y
  for i in 0..num_x
    p5.ellipse(r*i, r*j, r,r)#*n[i,j], r*n[i,j])
  end
end
  
p5.save()


