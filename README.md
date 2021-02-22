# svgOptimizer
Scaling,  re-formatting, positioning svg for my plotter <br> <br>
**READ THE NOTES**
<br> 
<br>
On a large display do:
`cmd shift R`

##controls:
|Keys            |Functions                  |
|----------------|:-------------------------:|
|`m`             |displaying/undisplaying    |
|                |max co-ordinate for origins|
|`c`             |displaying/undisplaying    |
|                |current co-ordinate origins|
|`<` `^` `>` `v` |arrow keys to move the curr|
|                |co-ordinates for new origin|
|`w` `a` `s` `d` |for moving the svg file    |
|`+` `-`         |for scaling/de-scaling svg |
|`l`             |to load an new svg file    |
|`q`             |to save the svg file       |
|`esc`           |to quit the application    |

### Notes:

* try it by downloading first the Latest [processing](https://processing.org/download/?processing)
* Use a large dislplay on mac
* Change the Prefrence: `Processing/preference/display/<larger display>`
* Then may be export as an `.app`
* It will save a text file with new origin(0, 0)co-ordinates. This is to help you later while using [g-code exporter](https://github.com/dattasaurabh82/svgToPlotterSpecificG-CODE) as if you have changed default origin, you might want to let the *g-code exporter* know as this will go in g-code later. 
