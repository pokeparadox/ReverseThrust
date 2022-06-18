extends Node2D
# A Scene which detects an incoming collision and at this point increases collision complexity in that quadrant
class_name ShrinkingDestructible

var DestructibleBlock = preload("DestructibleBlock.tscn")

export var BlockSize : int = 4
var Dimensions : Vector2 = Vector2(12,12)

func Setup(pos : Vector2, dims : Vector2) -> void:
	position = pos
	Dimensions = dims
	var blockCount : Vector2 = (Dimensions / BlockSize)
	$Top.NumBlocks = Vector2(blockCount.x-2, 1)
	$Bottom.NumBlocks = Vector2(blockCount.x-2, 1)
	$Left.NumBlocks = Vector2(1, blockCount.y)
	$Right.NumBlocks = Vector2(1, blockCount.y)
	$Top.Reset()
	$Bottom.Reset()
	$Left.Reset()
	$Right.Reset()
	var blockWidth : float = $Left.GetBlockWidth()
	$Left.position = Vector2.ZERO
	$Top.position = $Left.position + Vector2($Left.GetBlockWidth(), 0)
	$Right.position = Vector2(Dimensions.x -1 * blockWidth, 0)
	$Bottom.position  = $Left.position + Vector2($Left.GetBlockWidth(), Dimensions.y -1 * blockWidth)
	$Core/Shape.shape.extents = Vector2((blockCount.x-2) * blockWidth, (blockCount.y) * blockWidth) * 0.5
	$Core.position  = Dimensions * 0.5

func _draw() -> void:
	draw_rect(Rect2($Core/Shape.position, $Core/Shape.shape.extents * 2), Color.crimson)

func _on_Core_body_entered(body: Node) -> void:
	# Call hit on body
	if body.has_method("Hit"):
		body.Hit()

	# Work out which side was hit
	var pos : Vector2 = body.global_position
	var corePos : Vector2 = $Core.global_position
	var coreDims : Vector2 = $Core/Shape.shape.extents
	var centrePos : Vector2 = corePos + coreDims
	var blockCount : Vector2 = (Dimensions / BlockSize)
	if pos.x < centrePos.x:
		# Hit right
		$Core/Shape.shape.extents = coreDims - Vector2(BlockSize, 0)
		var blocks = DestructibleBlock.instance()
		blocks.NumBlocks = Vector2(1, blockCount.y)
		blocks.Reset()
		add_child(blocks)
	elif pos.x > centrePos.x:
		# Hit left
		$Core.position +=  Vector2(BlockSize, 0)
		var blocks = DestructibleBlock.instance()
		blocks.NumBlocks = Vector2(1, blockCount.y)
		blocks.Reset()
		blocks.position = $Core.position - Vector2(BlockSize, 0)
		add_child(blocks)
	elif pos.y > centrePos.y:
		# Hit top
		pass
	elif pos.y < centrePos.y:
		# Hit bottom
		pass




	# Shrink the side that was hit by the block size

	# Create row of destructible blocks to replace recessed border

	pass # Replace with function body.
