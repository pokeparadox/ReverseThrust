tool
class_name Rectangle
extends Node2D

export var is_filled : bool = true setget _set_is_filled
export var line_width : float = 1.0 setget _set_line_width
export var width : float = 4.0 setget _set_width
export var height : float = 4.0 setget _set_height
export var colour = Color.white setget _set_colour


func _draw() -> void:
	var dims = Vector2(width, height)
	draw_rect(Rect2(Vector2.ZERO, dims), colour, is_filled, line_width)


func _set_is_filled(value : bool) -> void:
	is_filled = value
	update()


func _set_line_width(value : float) -> void:
	line_width = value
	update()


func _set_width(w : float) -> void:
	width = w
	update()


func _set_height(h : float) -> void:
	height = h
	update()


func _set_colour(c : Color) -> void:
	colour = c
	update()

