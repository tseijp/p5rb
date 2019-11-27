require "./p5"

class Plt
  def initialize
    @p5 = P5.new()
    @p5.fill(255,255,255)
    @p5.size(512*2,288*2)
    @w  = @p5.width
    @h  = @p5.height
    @xlim = []
    @ylim = []
    @ps = 2
    @lw = 4
    @s  = 0.5 
    @step=10
    @color = [100,100,200]
    @p5.fill(0,0,0)
    @p5.line(@w*(1-@s)/2,@h*(1-@s)/2, @w*(1+@s)/2,@h*(1-@s)/2)
    @p5.line(@w*(1-@s)/2,@h*(1-@s)/2, @w*(1-@s)/2,@h*(1+@s)/2)
    @p5.line(@w*(1+@s)/2,@h*(1-@s)/2, @w*(1+@s)/2,@h*(1+@s)/2)
    @p5.line(@w*(1-@s)/2,@h*(1+@s)/2, @w*(1+@s)/2,@h*(1+@s)/2)
    @p5.fill(255,100,100)
  end
  def step(num)
    @step = num
  end
  def plot(inx, iny=[], ps=@ps, lw=@lw)
    if inx.length!=iny.length
      raise "Error: x and y does not match length."
    end
    if @xlim==[] && @ylim==[]
      @xlim = [inx.min,inx.max]
      @ylim = [iny.min,iny.max]
    end
    outx = inx.map{|x| @w*(1-@s)/2 + @w*@s*(x-@xlim[0])/(@xlim[1]-@xlim[0]) }
    outy = iny.map{|y| @h*(1-@s)/2 + @w*@s*(y-@ylim[0])/(@ylim[1]-@ylim[0]) }
    outx.zip(outy).each do |x,y|
      if @w*(1-@s)/2<x&&x<@w*(1+@s)/2 && @h*(1-@s)/2<y&&y<@h*(1+@s)/2
        @p5.ellipse(x,y, @ps/2,@ps/2)
      end
    end
    @color = [@color[1],@color[2],@color[0]]
  end
  def show()
    @p5.fill(0,0,0)
    @p5.strokeWeight(1)
    #puts @w,@h,@s,@xlim,@ylim,@step
    (@w*(1-@s)/2).step(@w*(1+@s)/2,@w*@s/@step) do |x|
      @p5.line(x, @h*(1-@s)/2, x, @h*(1+@s)/2)
    end
    (@h*(1-@s)/2).step(@h*(1+@s)/2,@h*@s/@step) do |y|
      @p5.line(@w*(1-@s)/2, y, @w*(1+@s)/2, y)
    end
    @p5.save()
  end
end

if __FILE__ == $0
  plt = Plt.new()
  plt.step(10)
  x = [*-100..100]
  
  y = x.map{|x| x*x - 100*x}
  plt.plot(x,y)
 
  y = x.map{|x| x*x + 100*x}
  plt.plot(x,y)

  y = x.map{|x| x*x}
  plt.plot(x,y)

  plt.show()
end

