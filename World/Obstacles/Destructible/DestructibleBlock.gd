extends Node2D
var Destructible = preload("Destructible.tscn")
export var NumBlocks : Vector2 = Vector2(2,150)

func GetBlockWidth() -> int:
	return self.get_child(0).get_node("CollisionShape2D").shape.extents.x

func _enter_tree() -> void:
	for y in range(0, NumBlocks.y):
		for x in range(0, NumBlocks.x):
			var block = Destructible.instance()
			block.SetColour(Color.aqua)
			block.position = Vector2(x*block.get_node("CollisionShape2D").get_shape().get_extents().x, y*block.get_node("CollisionShape2D").get_shape().get_extents().y)
			self.add_child(block)

func Reset() -> void:
	for child in self.get_children():
		child.queue_free()
	_enter_tree()
