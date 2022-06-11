extends Node2D
var Destructible = preload("Destructible.tscn")
export var NumBlocksHeight: int = 2
export var NumBlocksWidth : int = 150

func _enter_tree() -> void:
	for y in range(0, NumBlocksHeight):
		for x in range(0, NumBlocksWidth):
			var block = Destructible.instance()
			block.SetColour(Color.aqua)
			block.position = Vector2(x*block.get_node("CollisionShape2D").get_shape().get_extents().x, y*block.get_node("CollisionShape2D").get_shape().get_extents().y)
			self.add_child(block)

func Reset() -> void:
	for child in self.get_children():
		child.queue_free()
	_enter_tree()
