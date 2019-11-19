require './utils'

Pixel = Struct.new(:r, :g, :b)
class P5
  def initialize
    @output = "output.ppm"
    @encode = "ppm"
    @width  = 512 
    @height = 288
    @color  = [255,255,255]
    @alpha  = 1
    @isFill = true
    @linewidth   = 1
    @markerpoint = 1
  end
  def width
    @width
  end
  def height
    @height
  end
  def color(arr)
    @color
  end
  def fill(cr,cg,cb)
    @color = [cr,cg,cb]
  end
  def background(w, h)
    @image = Array.new(h) do
      Array.new(w) do Pixel.new(255-@color[0],255-@color[1],255-@color[2]) end
    end
    @width = w
    @height= h
  end
  def pset(x, y, r=0, g=@color[0], b=@color[1], a=@color[2])
    if x < 0 || x >= 300 || y < 0 || y >= 200 then return end
    @image[y][x].r = (@image[y][x].r * a + r * (1.0 - a)).to_i
    @image[y][x].g = (@image[y][x].g * a + g * (1.0 - a)).to_i
    @image[y][x].b = (@image[y][x].b * a + b * (1.0 - a)).to_i
  end
  def random(top)
    random = Random.new
    val = random.rand(0..top)
    val = val.to_i
    return val
  end
  def line(x1, y1, x2, y2)
    if @isFill==True
      fillline(x1,y1,x2,y2, @linewidth, @color[0], @color[1], @color[2], @alpha)
    end
  end
  def ellipse(x, y, rx, ry)
    j0 = (y-ry).to_i; j1 = (y+ry).to_i
    i0 = (x-rx).to_i; i1 = (x+rx).to_i
    j0.step(j1) do |j|
      i0.step(i1) do |i|
        if ((i-x).to_f/rx)**2 + ((j-y).to_f/ry)**2 < 1.0
          if block_given? then yield(i,j) else pset(i,j) end
        end
      end
    end
  end
  def save()
    open("t.ppm", "wb") do |f|
      f.puts("P6\n300 200\n255")
      @image.each do |a|
        a.each do |p| f.write(p.to_a.pack("ccc")) end
      end
    end
    system("convert t.ppm t.png")
    system("rm t.ppm")
  end
end

