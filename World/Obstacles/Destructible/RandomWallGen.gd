extends Node2D

var DestructibleBlock = preload("DestructibleBlock.tscn")
onready var screenRes : Vector2 = Resolution.GetResolution()

# Generate the random obstacle placement increasing in complexity with the increasing level.
func SetLevelObstacles(level):
	var halfRes : Vector2 = screenRes *0.5
	var scaler :float = float(level * 0.1)
	# Randomise positions of existing objects
	for _i in get_children():
		_i.position = Vector2(float(Random.NextIntRange(0, int(halfRes.x))), float(Random.NextIntRange(0, int(halfRes.y))))

	# Generate an extra obstacle
	var obstacle = DestructibleBlock.instance()
	# Generate the obstacle's position.
	obstacle.position.x = float(Random.NextIntRange(0, int(halfRes.x)))
	obstacle.position.y = float(Random.NextIntRange(0, int(halfRes.y)))
	obstacle.NumBlocksWidth = Random.NextIntRange(1, int(scaler * halfRes.x))
	obstacle.NumBlocksHeight = Random.NextIntRange(1, int(scaler * level + 0.5))

	# Add the obstacle to the scene.
	add_child(obstacle)
