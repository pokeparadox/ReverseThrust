extends Node2D
var Destructible = preload("Destructible.tscn")
export var NumBlocksHeight: int = 20
export var NumBlocksWidth : int = 200

func _init():
	for y in range(0, NumBlocksHeight):
		for x in range(0, NumBlocksWidth):
			var block = Destructible.instance()
			block.position = Vector2(x*block.get_node("CollisionShape2D").get_shape().get_extents().x, y*block.get_node("CollisionShape2D").get_shape().get_extents().y)
			self.add_child(block)
