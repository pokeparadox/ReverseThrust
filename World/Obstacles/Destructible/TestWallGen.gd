extends Node2D

var DestructibleBlock = preload("SubDividingDestructible.tscn")

# Generate the random obstacle placement increasing in complexity with the increasing level.
func SetLevelObstacles(_level):
	# Generate an extra obstacle
	var obstacle = DestructibleBlock.instance()
	# Generate the obstacle's position.
	obstacle.Setup(100)
	obstacle.position = Vector2(180, 150)
	add_child(obstacle)

	#var obstacle2 = DestructibleBlock.instance()
	# Generate the obstacle's position.
	#obstacle2.Setup(200)
	#obstacle2.position = Vector2(40, 150)
	#add_child(obstacle2)
