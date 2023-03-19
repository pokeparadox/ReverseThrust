@tool
class_name Square
extends Node2D

@export var is_filled : bool = true : set = _set_is_filled
@export var line_width : float = 1.0 : set = _set_line_width
@export var length : float = 4.0 : set = _set_length
@export var colour = Color.WHITE : set = _set_colour

func _draw() -> void:
	var half : float = length * 0.5
	if is_filled:
		draw_rect(Rect2(Vector2(-half,-half), Vector2(length, length)), colour, is_filled)
	else:
		draw_rect(Rect2(Vector2(-half,-half), Vector2(length, length)), colour, is_filled, line_width)


func _set_is_filled(value : bool) -> void:
	is_filled = value
	queue_redraw()


func _set_line_width(value : float) -> void:
	line_width = value
	queue_redraw()


func _set_length(value : float) -> void:
	length = value
	queue_redraw()


func _set_colour(value : Color) -> void:
	colour = value
	queue_redraw()

