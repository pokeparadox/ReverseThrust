extends Node2D
tool
class_name Line

export var LineWidth : float = 1.0
export var Length : float = 400.0
export var Colour = Color.white


func _draw():
	# draw a line starting at the position of the node and going to the position of the node + the length
	draw_line(Vector2.ZERO ,Vector2(0, Length),Colour, LineWidth)
