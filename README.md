# p5.rb

<p align="center">
<a href="https://github.com/tseijp/p5rb/raw/master/images/rand.png"><img width="200"
    src="https://github.com/tseijp/p5rb/raw/master/images/rand.png" alt="rand.rb"/></a>
<a href="https://github.com/tseijp/p5rb/raw/master/images/line.png"><img width="200"
    src="https://github.com/tseijp/p5rb/raw/master/images/line.png" alt="line.rb"/></a>
<a href="https://github.com/tseijp/p5rb/raw/master/images/graph.png"><img width="200"
    src="https://github.com/tseijp/p5rb/raw/master/images/graph.png" alt="graph.rb"/></a>
</p>

### References

- [Processing Reference](http://tetraleaf.com/p5_reference_alpha/index.html)
- [Processing Download](https://processing.org/download/)

### Getting Started

```ruby
require "p5rb"

p5 = P5.new()
p5.size(512, 288)

# write main process here

p5.save()
```

### Documents

_setup_

| Name  | Description | Examples |  
|:----- | :----------- | :------- |  
| size(int, int): void  | make image                   | `p5.size(512,288) #->w:512,h:288` |  
| width: int            | return value of image width  | `w = p5.width   #->512` |  
| height: int           | return value of image height | `h = p5.height #->288` |  
| color: [int, int, int]| return array of using  color | `c = p5.color  #->[255,255,255]` |  
| linewidth: int        | return value of line width   | `lw = p5.linewidth #->1` |  

_finish_

| Name  | Description | Examples |  
|:----- | :----------- | :------- |  
| save(): void | save image as t.png | `p5.save()` |  
| flip(): void | flip image up-down  | `p5.flip()` |  

_draw_

| Name  | Description | Examples |  
|:----- | :----------- | :------- |  
| pset (x, y, z): void        | set pixel    | `p5.pset(p5.width/2, p5.height/2)` |  
| line (x1, y1, x2, y2): void | draw line    | `p5.line(0, 0, p5.width, p5.height)` |  
| ellipse (x, y, ry, rx: void | draw ellipse | `p5.ellipse(p5.width/2, p5.height/2, 100, 100)` |  

_decorate_

| Name  | Description | Examples |  
|:----- | :----------- | :------- |  
| fill (r, g, b, a): void  | set color      | `p5.fill(0,0,0)` or `p5.fill([0,0,0])` |  
| strokeWeight (int): void | set line width | `p5.strokeWeight(5)` #->p5.line(0,0,99,99)` |  


_utils_

| Name  | Description | Examples |  
|:----- | :----------- | :------- |  
| rand(int)  | return random num in 0~int | `p5.random(100) #->0 or 25 or 99...` |  
| noise(int) | coming soon |-|  
