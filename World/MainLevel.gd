extends Node2D

@onready var CameraStartHeight : int = $Camera3D.position.y
@onready var WallOffset : int = CameraStartHeight - $LeftWall.position.y
@onready var FloorStartLastHeight : int = $DeathZone.position.y
@onready var FloorOffset : int = CameraStartHeight - FloorStartLastHeight
var GameLevel : int = 0

func _enter_tree():
	$Ship/Exhaust.reset()

func _physics_process(_delta: float) -> void:
	ProcessWallsAndFloor()
	CheckLevelProgression()


func ProcessWallsAndFloor() -> void:
	var camHeight : int = $Camera3D.position.y
	# run through Walls group objects
	var wall = get_tree().get_nodes_in_group("Walls")
	for i in wall:
		i.position.y = camHeight + WallOffset

	var change = camHeight + FloorOffset
	if FloorStartLastHeight < change:
		$DeathZone.position.y = change

func CheckLevelProgression() -> void:
	var levelShift : int = 800
	if $Ship.position.y < $LevelDivider.position.y:
		$ProgressiveMusicPlayer.SkipLoop()
		var nextDividerHeight : int = $LevelDivider.position.y - levelShift
		$LevelDivider.reset()
		$LevelDivider.position.y = nextDividerHeight
		GameLevel += 1
		$Ship/Exhaust.level_up()
		$Ship.Fuel += max(float(1000.0 / GameLevel), 10)
		$Ship.Fuel = min($Ship.Fuel, 100.0)
		$RandomWallGen.SetLevelObstacles(GameLevel)
		$RandomWallGen.position.y = $RandomWallGen.position.y - levelShift
