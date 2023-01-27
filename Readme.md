# FlxSVGSprite
## A specialized FlxSprite that can render SVG content in flixel.

### Setup
This library depends on my fork of openfl/svg, which can be found [here](https://github.com/UncertainProd/svg)
Be sure to install it using:
```cmd
haxelib git svg https://github.com/UncertainProd/svg.git
```
and then install this library using:
```cmd
haxelib git flxsvgsprite https://github.com/UncertainProd/FlxSVGSprite.git
```

And then add this entry to your Project.xml file:
```xml
<haxelib name="flxsvgsprite">
```

### Usage
Import `flixel.addons.display.FlxSVGSprite` at the top of your file.
```haxe
import flixel.addons.display.FlxSVGSprite;
```

And then instantiate it as follows:
```haxe
// ...
//                               x,  y, width,height, svg file path
var svgSprite = new FlxSVGSprite(50, 100, 36, 36, 'path/to/svgfile.svg');
add(svgSprite); // add it to the state
// ...
```

You can change the sprite's width and height using it's `displayWidth` and `displayHeight` properties.
```haxe
svgSprite.displayWidth = 60;
svgSprite.displayHeight = 30;
```

You can also change the svg that's being rendered on the sprite using the `loadSVGGraphic` method.
```haxe
svgSprite.loadSVGSprite('new/svg/path.svg');
```

For a basic example, check out the `samples/` folder