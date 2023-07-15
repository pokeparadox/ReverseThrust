extends Node2D

var DestructibleBlock = preload("SubDivRect.tscn")
@onready var screenRes : Vector2 = Resolution.get_resolution()
const SPACER_OFFSET : int = 50

# Generate the random obstacle placement increasing in complexity with the increasing level.
func set_level_obstacles(level):
	#Take area of all blocks and use this as a budget to create new blocks from each level up.
	#Bias toward width first randomly selecting within an increasing range.
	#Starting from the lowest part of the next screen
	#randomly choose a side of the screen (Left , Centre or Right)
	#Randomly choose to advance or to fill remaining positions
	#Move upwards the height of the block
	#deduct from area budget
	#Repeat from 4 until area budget is used up.
	#The area budget is increased every level completed
	var scaler : float = float(level * 0.5)
	var current_height : int = 40
	var segment_height : int = 40
	var blocks := get_children()
	var num_blocks : int = blocks.size()
	var block_budget : int = 2 + (2 * scaler)
	var max_block_width : int =  max(screenRes.x * 0.15 * scaler, screenRes.x * 0.3)  
	for b in blocks:
		b.queue_free() 
	
	while block_budget > 0:
		var gen_left : bool = Random.next_bool()
		var gen_centre : bool = Random.next_bool()
		var gen_right : bool = Random.next_bool()
		
		if gen_left and gen_centre and gen_right:
			var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width*3), segment_height)
			block_budget = block_budget - 3
			var obstacle = DestructibleBlock.instantiate()
			obstacle.colour = Color.WHITE
			obstacle.setup(dims)
			obstacle.position.y = current_height
			add_child(obstacle)
		elif gen_left and gen_centre:
			var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width*2), segment_height)
			block_budget = block_budget - 2
			var obstacle = DestructibleBlock.instantiate()
			obstacle.colour = Color.WHITE
			obstacle.setup(dims)
			obstacle.position.y = current_height
			add_child(obstacle)
		elif gen_right and gen_centre:
			var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width*2), segment_height)
			block_budget = block_budget - 2
			var obstacle = DestructibleBlock.instantiate()
			obstacle.colour = Color.WHITE
			obstacle.setup(dims)
			obstacle.position = Vector2(screenRes.x * 0.3, current_height)
			add_child(obstacle)
		else:
			if gen_left:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width), segment_height)
				block_budget = block_budget - 1
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position.y = current_height
				add_child(obstacle)
				
			if gen_centre:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width), segment_height)
				block_budget = block_budget - 1
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position = Vector2(screenRes.x * 0.3, current_height)
				add_child(obstacle)
				
			if gen_right:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width), segment_height)
				block_budget = block_budget - 1
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position = Vector2(screenRes.x - dims.x - segment_height, current_height)
				add_child(obstacle)
		# Endif
		current_height = current_height + segment_height
	
