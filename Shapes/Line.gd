tool
class_name Line
extends Node2D

export var line_width : float = 1.0 setget _set_line_width
export var length : float = 400.0 setget _set_length
export var colour = Color.white setget _set_colour


func _draw() -> void:
	draw_line(Vector2.ZERO, Vector2(0, length), colour, line_width)


func _set_line_width(value : float) -> void:
	line_width = value
	update()


func _set_length(value : float) -> void:
	length = value
	update()


func _set_colour(value : Color) -> void:
	colour = value
	update()

