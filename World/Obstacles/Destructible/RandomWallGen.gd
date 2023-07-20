extends Node2D

var DestructibleBlock = preload("SubDivRect.tscn")
@onready var screenRes : Vector2 = Resolution.get_resolution()
const SPACER_OFFSET : int = 50

# Types of generation
enum GenType 
{
	GEN_ALL, 
	GEN_LEFT_CENTRE,
	GEN_RIGHT_CENTRE,
	GEN_LEFT,
	GEN_RIGHT,
	GEN_CENTRE
}

const GEN_TYPES := [ 
	GenType.GEN_ALL, 
	GenType.GEN_LEFT_CENTRE,
	GenType.GEN_RIGHT_CENTRE,
	GenType.GEN_LEFT,
	GenType.GEN_RIGHT,
	GenType.GEN_CENTRE
	]

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
	var scaler : float = float(level * 0.25)
	const offset : int = 60
	var current_height : int = 40
	var segment_height : int = 40
	var blocks := get_children()

	var block_budget : int = int(2 + (2 * scaler))
	var max_block_width : int =  max(screenRes.x * 0.05 * scaler, screenRes.x * 0.2)  
	for b in blocks:
		b.queue_free() 
	
	while block_budget > 0:
		var choice : GenType = GEN_TYPES.pick_random()
		match choice:
			GenType.GEN_ALL:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width*2.5), segment_height)
				block_budget = block_budget - 3
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position.x += offset
				obstacle.position.y = current_height
				add_child(obstacle)
			GenType.GEN_LEFT_CENTRE:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width*2), segment_height)
				block_budget = block_budget - 2
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position.x += offset
				obstacle.position.y = current_height
				add_child(obstacle)
			GenType.GEN_RIGHT_CENTRE:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width*2), segment_height)
				block_budget = block_budget - 2
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position = Vector2(screenRes.x * 0.3, current_height)
				add_child(obstacle)
			GenType.GEN_LEFT:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width), segment_height)
				block_budget = block_budget - 1
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position.x = obstacle.position.x + offset
				obstacle.position.y = current_height
				add_child(obstacle)
			GenType.GEN_CENTRE:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width), segment_height)
				block_budget = block_budget - 1
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position = Vector2(screenRes.x * 0.3, current_height)
				add_child(obstacle)
			GenType.GEN_RIGHT:
				var dims: Vector2 = Vector2(Random.next_int_range(segment_height, max_block_width), segment_height)
				block_budget = block_budget - 1
				var obstacle = DestructibleBlock.instantiate()
				obstacle.colour = Color.WHITE
				obstacle.setup(dims)
				obstacle.position = Vector2((screenRes.x - dims.x - segment_height) - offset, current_height)
				add_child(obstacle)
		# End Match
		current_height = current_height + segment_height
	
