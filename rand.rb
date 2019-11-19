require "./p5"

p5 = P5.new()

p5.background(512, 288)

for i in 1..100 do
  rx = p5.random(p5.width/2 - 100)
  ry = p5.random(p5.height/2- 100)
  rr = p5.random(50)
  rc = p5.random(255)
  p5.fill(rc, 255, 255-rc)
  p5.ellipse(rx, ry, rr, rr)
end

p5.save()
