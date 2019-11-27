require './util/noise_utils.rb'

Pixel = Struct.new(:r, :g, :b)
class P5
  def initialize
    @output = "output.ppm"
    @encode = "ppm"
    @width  = 512 
    @height = 288
    @color  = [0,0,0]
    @alpha  = 0 
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
  def color
    @color
  end
  def linewidth
    @linewidth
  end
  def fill(cr=@color[0],cg=@color[1],cb=@color[2],ca=@alpha)
    if cr.instance_of?(Array)
      @color = [cr[0],cr[1],cr[2]]
      if cr.length>3
        @alpha = cr[3]
      end
    else
      @color = [cr,cg,cb]
      @alpha = ca
    end
  end
  def strokeWeight(width)
    @linewidth = width
  end
  def size(w, h)
    @image = Array.new(h) do
      Array.new(w) do Pixel.new(@color[0],@color[1],@color[2]) end
    end
    @width = w
    @height= h
  end
  def flip()
    image = Marshal.load(Marshal.dump( @image ))
    for i in 0..image.length-1
      @image[i] = image[image.length - i -1]
    end
  end
  def save()
    system("rm -f t.png")
    flip()
    open("t.ppm", "wb") do |f|
      f.puts("P6\n"+@width.to_s+" "+@height.to_s+"\n255")
      @image.each do |a|
        a.each do |p| f.write(p.to_a.pack("ccc")) end
      end
    end
    system("convert t.ppm t.png")
    system("rm t.ppm")
  end
  def pset(x, y)
    if x < 0 || x >= @width || y < 0 || y >= @height then return end
    @image[y][x].r = (@image[y][x].r*@alpha+@color[0]*(1.0-@alpha)).to_i
    @image[y][x].g = (@image[y][x].r*@alpha+@color[1]*(1.0-@alpha)).to_i
    @image[y][x].b = (@image[y][x].b*@alpha+@color[2]*(1.0-@alpha)).to_i
  end
  def random(top)
    random = Random.new
    val = random.rand(0..top)
    val = val.to_i
    return val
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

  def fillconvex(ax, ay)
    xmax = ax.max.to_i; xmin = ax.min.to_i
    ymax = ay.max.to_i; ymin = ay.min.to_i
    ymin.step(ymax) do |j|
      xmin.step(xmax) do |i|
       if isinside(i, j, ax, ay)
         if block_given? then yield(i,j) else pset(i,j) end
       end
      end
    end
  end
  def isinside(x, y, ax, ay)
    (ax.length-1).times do |i|
      if oprod(ax[i+1]-ax[i],ay[i+1]-ay[i],x-ax[i],y-ay[i])<0
        return false
      end
    end
    return true
  end  
  def line(x0, y0, x1, y1)
    dx = y1-y0; dy = x0-x1; n = 0.5*@linewidth / Math.sqrt(dx**2 + dy**2)
    dx = dx * n; dy = dy * n
    if block_given?
      fillconvex([x0-dx, x0+dx, x1+dx, x1-dx, x0-dx],
                 [y0-dy, y0+dy, y1+dy, y1-dy, y0-dy]) do |x,y| yield(x,y) end
    else
      fillconvex([x0-dx, x0+dx, x1+dx, x1-dx, x0-dx],
                 [y0-dy, y0+dy, y1+dy, y1-dy, y0-dy]) 
    end
  end
  def oprod(a, b, c, d)
    return a*d - b*c;
  end
end

