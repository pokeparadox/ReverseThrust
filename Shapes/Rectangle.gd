extends Node2D
tool
class_name Rectangle

export var IsFilled : bool = true
export var LineWidth : float = 1.0
export var Width : float = 4.0
export var Height : float = 4.0
export var Colour = Color.white


func _draw():
	# draw a square starting at the position with the given length
	var halfW : float = Width * 0.5
	var halfH : float = Height * 0.5
	draw_rect(Rect2(Vector2(-halfW,-halfH), Vector2(Width, Height)), Colour, IsFilled, LineWidth)
