tool
class_name Square
extends Node2D

export var is_filled : bool = true setget _set_is_filled
export var line_width : float = 1.0 setget _set_line_width
export var length : float = 4.0 setget _set_length
export var colour = Color.white setget _set_colour

func _draw() -> void:
	var half : float = length * 0.5
	draw_rect(Rect2(Vector2(-half,-half), Vector2(length, length)), colour, is_filled, line_width)


func _set_is_filled(value : bool) -> void:
	is_filled = value
	update()


func _set_line_width(value : float) -> void:
	line_width = value
	update()


func _set_length(value : float) -> void:
	length = value
	update()


func _set_colour(value : Color) -> void:
	colour = value
	update()

