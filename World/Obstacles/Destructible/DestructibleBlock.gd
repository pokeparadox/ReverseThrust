extends Node2D
var Destructible = preload("Destructible.tscn")
@export var num_blocks : Vector2 = Vector2(310,2)

func get_block_width() -> int:
	return self.get_child(0).get_node("CollisionShape2D").shape.size.x

func _enter_tree() -> void:
	for y in range(0, num_blocks.y):
		for x in range(0, num_blocks.x):
			var block = Destructible.instantiate()
			block.SetColour(Color.AQUA)
			var dims : Vector2 = block.get_node("CollisionShape2D").get_shape().size
			block.position = Vector2(x*dims.x, y*dims.y)
			self.add_child(block)

func reset() -> void:
	for child in self.get_children():
		child.queue_free()
	_enter_tree()
