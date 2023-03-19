extends Node2D

var DestructibleBlock = preload("SubDivRect.tscn")
@onready var screenRes : Vector2 = Resolution.get_resolution()
const SPACER_OFFSET : int = 50

# Generate the random obstacle placement increasing in complexity with the increasing level.
func SetLevelObstacles(level):
	var scaler : float = float(level * 0.75)
		# Create a new block randomly after the lowest position
	
	# Randomise positions of existing objects
	var obstacle = DestructibleBlock.instantiate()
	obstacle.colour = Color.WHITE
	# Generate the obstacle's position.
	var dims := Vector2(Random.next_int_range(SPACER_OFFSET, int(2 * scaler * level + SPACER_OFFSET)), Random.next_int_range(SPACER_OFFSET, int(scaler * level + SPACER_OFFSET)))
	obstacle.setup(dims)

	# Add the obstacle to the scene.
	add_child(obstacle)
	# Randomise the order of the differently sized blocks
	# We can do this by looping through all blocks and randomly picking an index to swap
	# We include the current index to allow for not swapping.
	var blocks := get_children()
	var num_blocks : int = blocks.size()
	for i in range(0, num_blocks-1):
		var new_i = Random.next_int_range(0, num_blocks-1)
		var t = blocks[i]
		blocks[i] = blocks[new_i]
		blocks[new_i] = t
	
	var lowest_block_pos : int = 0
	var screen_pos := Vector2(50, 100)
	# Once the orders have been swapped we lay them out in order with random offsets.
	# We keep track of the lowest blocks and move to the next line if the block can't fit horizontally.
	for b in blocks:
		var spacer_vector : Vector2 = Vector2(Random.next_int_range(0, SPACER_OFFSET + b.rect_dims.x), 0)
		b.position = screen_pos + spacer_vector
		if b.position.x + b.rect_dims.x > screenRes.x:
			spacer_vector.y = lowest_block_pos
			b.position = spacer_vector
			lowest_block_pos = b.position.y + b.rect_dims.y
		screen_pos = b.position + Vector2(b.rect_dims.x, 0)
