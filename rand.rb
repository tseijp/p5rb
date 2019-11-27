require "./p5"

p5 = P5.new()

p5.size(512*4, 288*4)

for i in 1..100 do
  rx = p5.random(p5.width)
  ry = p5.random(p5.height)
  rr = p5.random(50)
  rc = p5.random(255)
  ra = p5.random(255)/255
  p5.fill(rc, 255, 255-rc, ra)
  p5.ellipse(rx, ry, rr, rr)
end

p5.save()
