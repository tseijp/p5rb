
require "./p5"

p5 = P5.new()

p5.background(512, 288)
p5.fill(0,255,0)
p5.strokeWeight(5)
p5.line(p5.width/2,0,p5.width/2, p5.height)
p5.line(0,p5.height/2,p5.width, p5.height/2)
p5.line(0,0, 100,100)
p5.save()
