extends Node2D
class_name Square

export var IsFilled : bool = true
export var LineWidth : float = 1.0
export var Length : float = 4.0
export var Colour = Color.white


func _draw():
	# draw a square starting at the position with the given length
	var half : float = Length * 0.5
	draw_rect(Rect2(Vector2(-half,-half), Vector2(Length, Length)), Colour, IsFilled, LineWidth)
