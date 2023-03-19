extends Node2D

class_name SubDivRect

var SubDividingDestructible = load("res://World/Obstacles/Destructible/SubDividingDestructible.tscn")
var rect_dims : Vector2
var colour = Color.AQUAMARINE

# An class which takes a set of rectangular dimensions and fills it with an appropriate number of subdiv blocks
func setup(dimensions : Vector2) -> void:
	rect_dims = dimensions
	# figure out which dimension is shortest and decide to build square blocks horizontally or vertically.
	if rect_dims.x > rect_dims.y:
		build_horizontally(rect_dims)
	else:
		build_vertically(rect_dims)


func build_horizontally(dimensions : Vector2) -> void:
	# Take the height as the destructible size
	var block_size = dimensions.y
	var num_blocks: int = dimensions.x/block_size
	for _i in range(num_blocks):
		# Generate an extra obstacle
		var obstacle = SubDividingDestructible.instantiate()
		# Generate the obstacle's position.
		obstacle.position.x = _i * block_size 
		obstacle.setup(block_size, colour)
		# Add the obstacle to the scene.
		add_child(obstacle)
	
func build_vertically(dimensions : Vector2) -> void:
	# Take the width as the destructible size
	var block_size = dimensions.x
	var num_blocks: int = dimensions.y/block_size
	for _i in range(num_blocks):
		# Generate an extra obstacle
		var obstacle = SubDividingDestructible.instantiate()
		# Generate the obstacle's position.
		obstacle.position.y = _i * block_size 
		obstacle.setup(block_size, colour)
		# Add the obstacle to the scene.
		add_child(obstacle)

func reset() -> void:
	for child in self.get_children():
		child.queue_free()
	setup(rect_dims)
