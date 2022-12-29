extends Node2D

var DestructibleBlock = preload("SubDividingDestructible.tscn")
onready var screenRes : Vector2 = Resolution.GetResolution()
const SpacerOffset : int = 50
# Generate the random obstacle placement increasing in complexity with the increasing level.
func SetLevelObstacles(level):
	var halfRes : Vector2 = screenRes *0.5
	var scaler :float = float(level * 2)
	# Randomise positions of existing objects
	for _i in get_children():
		_i.position = Vector2(float(Random.NextIntRange(SpacerOffset, int(screenRes.x - SpacerOffset))), float(Random.NextIntRange(SpacerOffset, int(halfRes.y - SpacerOffset))))

	# Generate an extra obstacle
	var obstacle = DestructibleBlock.instance()
	# Generate the obstacle's position.
	obstacle.position.x = float(Random.NextIntRange(SpacerOffset, int(screenRes.x -SpacerOffset)))
	obstacle.position.y = float(Random.NextIntRange(SpacerOffset, int(screenRes.y -SpacerOffset)))
	obstacle.setup(Random.NextIntRange(SpacerOffset, int(scaler * level + SpacerOffset)), Color.white)

	# Add the obstacle to the scene.
	add_child(obstacle)
