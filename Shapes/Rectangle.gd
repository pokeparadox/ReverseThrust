@tool
class_name Rectangle
extends Node2D

@export var is_filled : bool = true : set = _set_is_filled
@export var line_width : float = 1.0 : set = _set_line_width
@export var width : float = 4.0 : set = _set_width
@export var height : float = 4.0 : set = _set_height
@export var colour = Color.WHITE : set = _set_colour


func _draw() -> void:
	var dims = Vector2(width, height)
	if is_filled:
		draw_rect(Rect2(Vector2.ZERO, dims), colour, is_filled)
	else:
		draw_rect(Rect2(Vector2.ZERO, dims), colour, is_filled, line_width)


func _set_is_filled(value : bool) -> void:
	is_filled = value
	queue_redraw()


func _set_line_width(value : float) -> void:
	line_width = value
	queue_redraw()


func _set_width(w : float) -> void:
	width = w
	queue_redraw()


func _set_height(h : float) -> void:
	height = h
	queue_redraw()


func _set_colour(c : Color) -> void:
	colour = c
	queue_redraw()

