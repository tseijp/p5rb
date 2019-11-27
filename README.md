# p5.rb

### ref

* [Processing Reference](http://tetraleaf.com/p5_reference_alpha/index.html)
* [Processing Download](https://processing.org/download/)

### get started

```ruby
require "./p5"
p5 = P5.new()
p5.size(512, 288)

# write main process here

p5.save()
```

### cheat sheet

_setup_

|name|doc|how to|  
|:-|:-|:-|  
|size(int,int)|make image|`p5.size(512,288) #->w:512,h:288`|  
|width |return value of image width|`w = p5.width   #->512`|  
|height|return value of image height|`h = p5.height #->288`|  
|color |return array of using  color|`c = p5.color  #->[255,255,255]`|  
|linewidth|return value of line width|`lw = p5.linewidth #->1`|  

_end_

|name|doc|how to|  
|:-|:-|:-|  
|save|save image as t.png|`p5.save()`|  
|flip|flip image up-down|`p5.flip()`|  

_draw_

|name|doc|how to|  
|:-|:-|:-|  
|pset(x,y)|set pixel in [x,y]|`p5.pset(p5.width/2, p5.height/2)`|  
|line(x1,y1,x2,y2)|draw line [x1,y1] to [x2,y2]|`p5.line(0,0,p5.width,p5.height)`|  
utipse(x, y, rx, ry)|draw ellipse in [x,y]   |p5.ellipse(p5.width/2,p5.height/2,100,100)|  

_decorate_

|name|doc|how to|  
|:-|:-|:-|  
|fill(r,g,b,a)|set color|`p5.fill(0,0,0)` or `p5.fill([0,0,0])`|  
|strokeWeight(int)|set line width|`p5.strokeWeight(5)` #->p5.line(0,0,99,99)|  


util

|name|doc|how to|  
|:-|:-|:-|  
|rand(int)|return random num in 0~int|`p5.random(100) #->0 or 25 or 99...`|  
|noise(int)|coming soon|-|  



### dev

p5rb
  - p5.rb : main module
  - util  : for p5.rb
    - noise\_utils.rb
    - perlin: for noise\_utils.rb

rand.rb 

<p align="left">
<img src="https://github.com/YouseiTakei/p5rb/blob/master/images/rand.png", width="512">
</p>

line.rb

<p align="left">
<img src="https://github.com/YouseiTakei/p5rb/blob/master/images/rand.png", width="512">
</p>

graph.rb

<p align="left">
<img src="https://github.com/YouseiTakei/p5rb/blob/master/images/graph.png", width="512">
</p>

noise.rb

_coming soon_

