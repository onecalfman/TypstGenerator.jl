#let project(title, doc) = {
set document(author: ("Author"), title: title)
doc
}
#show: project.with("Report")
	
#set page(margin: (left: 20.0mm, right: 20.0mm, top: 30.0mm, bottom: 30.0mm), footer: grid(columns: (1fr, 1fr), 
  align(left,   image(height: 12.0mm, "example/typst_banner.png") ),
  align(right,   image(height: 12.0mm, "example/julia.svg") )) )
#set heading(numbering: "I.I")
#page()[
  #outline() 
  #heading(level: 1, "Report") 
  #v(12.0mm)
  #set align(center)
  #grid(
    rect(height: 10.0mm, width: 3.0mm,       align(horizon,       text("1") )) ,
    rect(height: 10.0mm, width: 6.0mm,       align(horizon,       text("2") )) ,
    rect(height: 10.0mm, width: 9.0mm,       align(horizon,       text("3") )) ) 
  #set align(left)
  #lorem(200)
  #heading(level: 2, "Important Topic") 
  #lorem(200)
  #set align(center)]
#page(background: place(center + horizon,  rotate(45.0deg,    text(font: "Source Sans Pro", fill: luma(204), size: 60.0mm, "WATERMARK") )))[
  #grid(columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr), 
    rotate(1.0deg,      square(fill: rgb(33, 3, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(6.0deg,      square(fill: rgb(33, 18, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(11.0deg,      square(fill: rgb(33, 33, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(16.0deg,      square(fill: rgb(33, 48, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(21.0deg,      square(fill: rgb(33, 63, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(26.0deg,      square(fill: rgb(33, 78, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(31.0deg,      square(fill: rgb(33, 93, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(36.0deg,      square(fill: rgb(33, 108, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(41.0deg,      square(fill: rgb(33, 123, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(46.0deg,      square(fill: rgb(33, 138, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(51.0deg,      square(fill: rgb(33, 153, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(56.0deg,      square(fill: rgb(33, 168, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(61.0deg,      square(fill: rgb(33, 183, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(66.0deg,      square(fill: rgb(33, 198, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(71.0deg,      square(fill: rgb(33, 213, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(76.0deg,      square(fill: rgb(33, 228, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(81.0deg,      square(fill: rgb(33, 243, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) ),
    rotate(86.0deg,      square(fill: rgb(33, 255, 100), size: 20.0mm,         align(bottom, $ A =  pi r^2 $)) )) 
  #v(10.0mm)
  #figure(caption: text("The Julia language logo") ,     image(height: 50.0mm, "example/julia.svg") ) <test_fig>
  #align(center,   block(radius: 2.0mm, fill: cmyk(10%, 20%, 30%, 10%), inset: 4.2333333333333325mm)[
    #numbering("i.i)", 531441, 2349)
    #lorem(20)
    #ref(<test_fig>)
    #lorem(20)
$ A = pi ^2 $
    #lorem(20)
    #footnote()[      #lorem(10)]
$A = pi ^2$
    #lorem(20)])
  #v(20.0mm)
  #grid(columns: (1fr, 1fr, 1fr, 1fr), 
    list(
      text("Lorem") ,
      text("ipsum") ,
      text("dolor") ,
      text("sit") ,
      text("amet") ) ,
    enum(
      grid(columns: (10.583333333333332mm, 3.5277777777777777mm), 
        text("x^1") ) ,
      grid(columns: (10.583333333333332mm, 3.5277777777777777mm), 
        text("x^2") ) ,
      grid(columns: (10.583333333333332mm, 3.5277777777777777mm), 
        text("x^3") ) ,
      grid(columns: (10.583333333333332mm, 3.5277777777777777mm), 
        text("x^4") ) ,
      grid(columns: (10.583333333333332mm, 3.5277777777777777mm), 
        text("x^5") ) ) ,
    enum(
      text("Lorem") ,
      text("ipsum") ,
      text("dolor") ,
      text("sit") ,
      text("amet") ) ,
    enum(
      text("Lorem") ,
      text("ipsum") ,
      text("dolor") ,
      text("sit") ,
      text("amet") ,
      enum(full: true, start: 4, 
        text("Lorem") ,
        text("ipsum") ,
        text("dolor") ,
        text("sit") ,
        text("amet") ) ) ) ]
#page(margin: (left: 20.0mm, right: 20.0mm))[
  #figure(caption: "The industrial revolution was a distaster for mankind",     grid(columns: (1fr, 2fr, 3fr, 4fr, 5fr), 
      square(size: 2.0mm, ) ,
      square(size: 12.0mm, ) ,
      square(size: 22.0mm, ) ,
      square(size: 32.0mm, ) ,
      square(size: 42.0mm, ) ) ) <uncle_ted>
  #lorem(100)
  #cite("netwok2020")
  #lorem(50)
  #ref(<uncle_ted>)
  #lorem(100)
  #bibliography("example/bibliography.bib") ]