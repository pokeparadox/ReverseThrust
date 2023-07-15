extends Node2D



# TODO Update generation of this to be a double row of 4x4 destructible blocks The subdiv blocks slow progress too much.

#func _enter_tree():
#	$SubDivRect.colour = Color.AQUAMARINE
#	$SubDivRect.setup(dimensions)


func reset() -> void:
	$AudioStreamPlayer.play()
	$DestructibleBlock.reset()
