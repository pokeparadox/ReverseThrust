class_name Ship
extends KinematicBody2D
var Brad = load("Maths/Brad.gd")

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var screenRes : Vector2 = Resolution.GetResolution()

var shipHeading : Brad
const ROTATE_SPEED : int = 200
const THRUST_SPEED : int = 20

const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2.ZERO

func _init() -> void:
	shipHeading = Brad.new()

func _ready() -> void:
	self.position = screenRes * 0.5

func _physics_process(delta):
	var rot = -(Input.get_action_strength("RotateLeft") - Input.get_action_strength("RotateRight"))
	shipHeading = shipHeading.AddAngle(rot * delta * ROTATE_SPEED)
	SetShipThrusterAngle(shipHeading.GetAngleDeg())

	if Input.is_action_pressed("Thrust"):
		var vec : Vector2 = BradLut.BradToVector2d(shipHeading) * delta * THRUST_SPEED
		vec.y = -vec.y
		_velocity += vec
	_velocity.y += gravity * delta * 0.01
	self.position += _velocity


func SetShipThrusterAngle(thrust: float):
	$Thruster.rotation_degrees = thrust