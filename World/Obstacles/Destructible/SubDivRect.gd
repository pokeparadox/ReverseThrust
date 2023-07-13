extends Node2D

class_name SubDivRect

var SubDividingDestructible = load("res://World/Obstacles/Destructible/SubDividingDestructible.tscn")
var rect_dims : Vector2
var colour = Color.AQUAMARINE

# An class which takes a set of rectangular dimensions and fills it with an appropriate number of subdiv blocks
func setup(dimensions : Vector2) -> void:
	rect_dims = dimensions
	var obstacle = SubDividingDestructible.instantiate()
	obstacle.setup_w_h(rect_dims, colour)
	add_child(obstacle)
	

func reset() -> void:
	for child in self.get_children():
		child.queue_free()
	setup(rect_dims)
