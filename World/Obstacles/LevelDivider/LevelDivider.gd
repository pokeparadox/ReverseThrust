extends Node2D

var dimensions : Vector2 = Vector2(Resolution.get_width(),32)


func _enter_tree():
	$SubDivRect.colour = Color.aquamarine
	$SubDivRect.setup(dimensions)


func reset() -> void:
	$AudioStreamPlayer.play()
	$SubDivRect.reset()
