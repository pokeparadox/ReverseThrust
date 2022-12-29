extends Node2D

export var dimensions : Vector2 = Vector2(Resolution.GetWidth()-38,8)

func _enter_tree():
	$SubDivRect.colour = Color.aquamarine
	$SubDivRect.rect_dims = dimensions

func reset() -> void:
	$AudioStreamPlayer.play()
	$SubDivRect.reset()
