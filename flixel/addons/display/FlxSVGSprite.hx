package flixel.addons.display;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame;
import flixel.math.FlxAngle;
import flixel.math.FlxMatrix;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import format.SVG;
import format.svg.SVGData;
import openfl.Assets;

class FlxSVGSprite extends FlxSprite { // A lot of code has been taken from FlxShape from flixel-addons
	var svgLoader:SVG;

	/**
	 * The width of the SVG's graphic
	 */
	public var displayWidth(default, set):Float;

	/**
	 * The width of the SVG's graphic
	 */
	public var displayHeight(default, set):Float;

	var isDirty:Bool = false;

	public function new(X:Float = 0.0, Y:Float = 0.0, ?width:Float, ?height:Float, SVGPath:String) {
		super(X, Y);
		svgLoader = new SVG(Assets.getText(SVGPath));

		this.width = displayWidth = (width != null) ? width : svgLoader.data.width;
		this.height = displayHeight = (height != null) ? height : svgLoader.data.height;

		scale.set(1, 1);
		origin.set(displayWidth * 0.5, displayHeight * 0.5);
		makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
		fixBoundaries(width, height);
		isDirty = true;
	}

	public function redrawShape() {
		var diffX:Int = Std.int(displayWidth) - pixels.width;
		var diffY:Int = Std.int(displayHeight) - pixels.height;
		if (diffX != 0 || diffY != 0) {
			var trueWidth:Float = displayWidth;
			var trueHeight:Float = displayHeight;
			makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
			fixBoundaries(trueWidth, trueHeight);
		} else {
			pixels.fillRect(pixels.rect, FlxColor.TRANSPARENT);
		}
		prepareMatrix();
		FlxSVGUtil.drawSVG(this, svgLoader, _matrix);
	}

	function fixBoundaries(trueWidth:Float, trueHeight:Float):Void {
		width = trueWidth; // reset width/height to geometric reality
		height = trueHeight;
		offset.x = 0;
		offset.y = 0;
		isDirty = true; // redraw the shape next draw() command
	}

	override function draw() {
		if (isDirty) {
			redrawShape();
			isDirty = false;
		}
		super.draw();
	}

	function prepareMatrix() {
		_matrix.identity();
		_matrix.scale(scale.x * displayWidth / svgLoader.data.width, scale.y * displayHeight / svgLoader.data.height);
		// _matrix.rotate(angle * FlxAngle.TO_RAD);
		// var to = origin.copyTo().rotateByDegrees(angle);
		// var delta = origin - to;
		// _matrix.translate(delta.x, delta.y);
		// _matrix.translate(x, y);
	}

	public function loadSVGGraphic(SVGPath:String) {
		svgLoader.data = new SVGData(Xml.parse(Assets.getText(SVGPath)));
		isDirty = true;
	}

	function set_displayHeight(value:Float):Float {
		origin.y = displayHeight * 0.5;
		isDirty = true;
		return displayHeight = value;
	}

	function set_displayWidth(value:Float):Float {
		origin.x = displayWidth * 0.5;
		isDirty = true;
		return displayWidth = value;
	}
}

class FlxSVGUtil {
	public static function drawSVG(sprite:FlxSprite, svgLoader:SVG, matrix:FlxMatrix) {
		FlxSpriteUtil.beginDraw(FlxColor.TRANSPARENT, null);
		svgLoader.render(FlxSpriteUtil.flashGfx, 0, 0, -1, -1, matrix);
		FlxSpriteUtil.endDraw(sprite);
		return sprite;
	}
}
