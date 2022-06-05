extends Node2D
onready var CameraStartHeight : int = $Camera.position.y
onready var WallOffset : int = CameraStartHeight - $LeftWall.position.y
onready var FloorStartLastHeight : int = $DeathZone.position.y
onready var FloorOffset : int = CameraStartHeight - FloorStartLastHeight


func _physics_process(_delta: float) -> void:
	var camHeight : int = $Camera.position.y
	# run through Walls group objects
	var wall = get_tree().get_nodes_in_group("Walls")
	for i in wall:
		i.position.y = camHeight + WallOffset

	var change = camHeight + FloorOffset
	if FloorStartLastHeight < change:
		$DeathZone.position.y = change
