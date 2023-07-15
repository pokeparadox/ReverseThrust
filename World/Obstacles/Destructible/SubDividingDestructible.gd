extends Node2D
# A Scene which detects an incoming collision and at this point increases collision complexity in that quadrant
class_name SubDividingDestructible

var rect_dims : Vector2 = Vector2.ZERO
var IsHitting : bool = false
const min_length : int = 8
var colour : Color

func setup_w_h(dims : Vector2, c : Color) -> void:
	rect_dims = dims
	colour = c
	var halfDims : Vector2 = dims * 0.5
	$TopLeft.position = Vector2.ZERO
	$TopLeft.SetDims(halfDims)
	$TopLeft.SetColour(c)
	$TopRight.position = Vector2(halfDims.x, 0)
	$TopRight.SetDims(halfDims)
	$TopRight.SetColour(c)
	$BottomRight.position = halfDims
	$BottomRight.SetDims(halfDims)
	$BottomRight.SetColour(c)
	$BottomLeft.position = Vector2(0, halfDims.y)
	$BottomLeft.SetDims(halfDims)
	$BottomLeft.SetColour(c)


func setup(_length : int, c : Color) -> void:
	var length = int(max(min_length, _length))
	rect_dims = Vector2(length, length)
	setup_w_h(rect_dims, c)

func set_colour(c : Color) -> void:
	colour = c

func SetPosition(pos : Vector2) -> void:
	self.position = pos

func build_horizontally(pos : Vector2, dimensions : Vector2) -> void:
	# Take the height as the destructible size
	var block_size = dimensions.y
	var num_blocks: int = dimensions.x/block_size
	for _i in range(num_blocks):
		# Generate an extra obstacle
		var obstacle = load(self.scene_file_path).instantiate()
		# Generate the obstacle's position.
		obstacle.position = pos - (Vector2(dimensions.x, block_size) * 0.25) 
		obstacle.setup(block_size, colour)
		obstacle.position.x = obstacle.position.x + (_i * block_size) 
		
		# Add the obstacle to the scene.
		call_deferred("add_child", obstacle)
	
func build_vertically(pos : Vector2, dimensions : Vector2) -> void:
	# Take the width as the destructible size
	var block_size = dimensions.x
	var num_blocks: int = dimensions.y/block_size
	for _i in range(num_blocks):
		# Generate an extra obstacle
		var obstacle = load(self.scene_file_path).instantiate()
		# Generate the obstacle's position.
		obstacle.position = pos #- (Vector2(block_size, dimensions.y) * 0.5) 
		obstacle.position.y = obstacle.position.y + (_i * block_size) 
		obstacle.setup(block_size, colour)
		# Add the obstacle to the scene.
		call_deferred("add_child", obstacle)

func DestructibleHit(destructible : Destructible) -> void:
	if IsHitting:
		return

	IsHitting = true
	var pos : Vector2 = destructible.position
	var _dims : Vector2 = destructible.get_dimensions()
	var _halfDims : Vector2 = destructible.get_half_dimensions()
	destructible.queue_free()

	var new_pos : Vector2 = pos - _halfDims * 0.5
	
	if _halfDims.x < min_length:
		build_vertically(new_pos, _dims)
	elif _halfDims.y < min_length:
		build_horizontally(new_pos, _dims)
	else:
		# Create a new SubdividingDestructible at pos with dims
		var newDestructible = load(self.scene_file_path).instantiate()
		newDestructible.setup_w_h(_dims, colour)
		newDestructible.SetPosition(new_pos)
		call_deferred("add_child", newDestructible)
	IsHitting = false

func _on_TopLeft_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)


func _on_TopRight_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)


func _on_BottomLeft_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)


func _on_BottomRight_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)

func reset() -> void:
	for child in self.get_children():
		child.queue_free()
	setup_w_h(rect_dims, colour)
