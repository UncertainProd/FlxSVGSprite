package flixel.addons.display;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame;
import flixel.math.FlxAngle;
import flixel.util.FlxColor;
import format.SVG;
import format.svg.SVGData;
import openfl.Assets;

class FlxSVGSprite extends FlxSprite {
	var svgLoader:SVG;

	/**
	 * The width of the SVG's graphic
	 */
	public var displayWidth(default, set):Float;

	/**
	 * The width of the SVG's graphic
	 */
	public var displayHeight(default, set):Float;

	public function new(X:Float = 0.0, Y:Float = 0.0, ?width:Float, ?height:Float, SVGPath:String) {
		super(X, Y);
		svgLoader = new SVG(Assets.getText(SVGPath));

		this.width = displayWidth = (width != null) ? width : svgLoader.data.width;
		this.height = displayHeight = (height != null) ? height : svgLoader.data.height;

		scale.set(1, 1);
		origin.set(displayWidth * 0.5, displayHeight * 0.5);
	}

	override function draw() {
		for (camera in cameras) {
			if (!camera.visible || !camera.exists)
				continue;

			prepareMatrix(camera);
			svgLoader.render(camera.canvas.graphics, _matrix);
		}
	}

	function prepareMatrix(camera:FlxCamera) {
		_matrix.identity();
		_matrix.scale(scale.x * displayWidth / svgLoader.data.width, scale.y * displayHeight / svgLoader.data.height);
		_matrix.rotate(angle * FlxAngle.TO_RAD);
		var to = origin.copyTo().rotateByDegrees(angle);
		var delta = origin - to;
		_matrix.translate(delta.x, delta.y);
		_matrix.translate(x, y);
	}

	public function loadSVGGraphic(SVGPath:String) {
		svgLoader.data = new SVGData(Xml.parse(Assets.getText(SVGPath)));
	}

	function set_displayHeight(value:Float):Float {
		origin.y = displayHeight * 0.5;
		return displayHeight = value;
	}

	function set_displayWidth(value:Float):Float {
		origin.x = displayWidth * 0.5;
		return displayWidth = value;
	}
}
