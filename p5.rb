Pixel = Struct.new(:r, :g, :b)

class P5
    def initialize
        @o = "output.ppm" # output path
        @e = "ppm"        # encode format
        @w = 512 # width size
        @h = 256 # height size
        @d = 1   # depth size
        @r = 0   # pixel color of red
        @g = 0   # pixel color of grenn
        @b = 0   # pixel color of blue
        @a = 0   # pixel color of alpha
        @lw = 1  # line width
        @mp = 1  # marker point
        @isFill = true
    end
    #
    # setting functions
    #
    def fill (cr=@r, cg=@g, cb=@b,ca=@a)
        if cr.instance_of?(Array)
            @r = cr[0] || @r; @g = cr[1] || @g
            @b = cr[2] || @b; @a = cr[3] || @a
        else
            @r = cr @g = cb @b = cb @a = ca
        end
    end
    def strokeWeight (w=0)
        @lw = w
    end
    def size (w=@w, h=@h)
        @w = w
        @h = h
        @image = Array.new(@h) do Array.new(@w) do Pixel.new(@r,@g, @b) end end
    end
    def flip ()
        image = Marshal.load(Marshal.dump( @image ))
        for i in 0..image.length - 1
            @image[i] = image[image.length - i -1]
        end
    end
    #
    # rendering functions
    #
    def ellipse (x=@w/2, y=@h/2, rx=@w/2, ry=@h/2)
        (y - ry).step(y + ry) do |j|
            (x - rx).step(x - ry) do |i|
                if ((i-x).to_f/rx)**2 + ((j-y).to_f/ry)**2 < 1.0
                    if block_given? then yield(i,j) else pset(i,j) end
                end
            end
        end
    end
    def line(x0, y0, x1, y1)
        dx = y1 - y0; dy = x0 - x1; n = 0.5*@lw / Math.sqrt(dx**2 + dy**2)
        dx = dx *  n; dy = dy *  n
        if block_given?
            convex([x0-dx, x0+dx, x1+dx, x1-dx, x0-dx],
                   [y0-dy, y0+dy, y1+dy, y1-dy, y0-dy]) do |x,y| yield(x,y) end
        else
            convex([x0-dx, x0+dx, x1+dx, x1-dx, x0-dx],
                   [y0-dy, y0+dy, y1+dy, y1-dy, y0-dy])
        end
    end
    def convex (ax, ay)
        ay.min.step(ay.max) do |j|
            ax.min.step(ax.max) do |i|
                if isInside(i, j, ax, ay)
                    if block_given? then yield(i,j) else pset(i,j) end
                end
            end
        end
    end
    #
    # utilities
    #
    def random(top)
        random = Random.new
        val = random.rand(0..top)
        val = val.to_i
        return val
    end
    def pset(x, y)
        if x < 0 || x >= @w || y < 0 || y >= @h then return end
        @image[y][x].r = (@image[y][x].r * @a + @r * (1.0-@a)).to_i
        @image[y][x].g = (@image[y][x].r * @a + @g * (1.0-@a)).to_i
        @image[y][x].b = (@image[y][x].b * @a + @b * (1.0-@a)).to_i
    end
    def isInside(x, y, ax, ay)
        (ax.length-1).times do |i|
            if oprod(ax[i+1]-ax[i],ay[i+1]-ay[i],x-ax[i],y-ay[i])<0
                return false
            end
        end
        return true
    end
    def oprod(a, b, c, d)
        return a*d - b*c;
    end
    def save ()
        system("rm -f t.png")
        flip()
        open("t.ppm", "wb") do |f|
            f.puts("P6\n"+@w.to_s+" "+@h.to_s+"\n255")
            @image.each do |a|
                a.each do |p| f.write(p.to_a.pack("ccc")) end
            end
        end
        system("convert t.ppm t.png")
        system("rm t.ppm")
    end
    #
    # shorthands
    #
    def width
        return @w
    end
    def height
        return @h
    end
    def color
        return @c
    end
    def linewidth
        return @lw
    end
end
