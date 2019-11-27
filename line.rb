require "./p5"
p5 = P5.new()
color_w = [255,255,255]
color_b = [0  ,39 ,118]
color_r = [200,16 ,46]

p5.fill(color_b)
p5.size(512*4, 288*4)

p5.fill(color_w)
p5.strokeWeight(p5.height/5)
p5.line(0,0, p5.width, p5.height)
p5.line(p5.width, 0, 0, p5.height)

p5.fill(color_r)
p5.strokeWeight(p5.height/15)
p5.line(0,0, p5.width, p5.height)
p5.line(p5.width, 0, 0, p5.height)

p5.fill(color_w)
p5.strokeWeight(p5.height/4)
p5.line(0, p5.height/2, p5.width, p5.height/2)
p5.line(p5.width/2, 0, p5.width/2, p5.height)

p5.fill(color_r)
p5.strokeWeight(p5.height/7)
p5.line(0, p5.height/2, p5.width, p5.height/2)
p5.line(p5.width/2, 0, p5.width/2, p5.height)

p5.save()
