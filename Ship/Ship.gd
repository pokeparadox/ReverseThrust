class_name Ship
extends KinematicBody2D
var Brad = load("Maths/Brad.gd")

onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
onready var screenRes : Vector2 = Resolution.GetResolution()

var shipHeading : Brad
const ROTATE_SPEED : int = 200
const THRUST_SPEED : int = 20


var _velocity = Vector2.ZERO

func _init() -> void:
	shipHeading = Brad.new()

func _ready() -> void:
	_velocity = Vector2.ZERO
	self.position = screenRes * 0.5
	shipHeading.SetAngle(0)
	$Exhaust.SetExhaust(false)
	$Exhaust.visible = false
	$Explosion.Explode(false)
	setShipVisible(true)

func _physics_process(delta):
	var isExploding = $ExplodeSound.is_playing()
	$Exhaust.visible = not isExploding
	if isExploding:
		return

	var rot = -(Input.get_action_strength("RotateLeft") - Input.get_action_strength("RotateRight"))
	shipHeading = shipHeading.AddAngle(rot * delta * ROTATE_SPEED)
	SetShipThrusterAngle(shipHeading.GetAngleDeg())

	if Input.is_action_pressed("Thrust"):
		var vec : Vector2 = BradLut.BradToVector2d(shipHeading) * delta * THRUST_SPEED
		vec.y = -vec.y
		_velocity += vec
		$Exhaust.SetExhaust(true)
		if not $ExhaustSound.is_playing():
			$ExhaustSound.play()
	else:
		_velocity *= 0.99
		$Exhaust.SetExhaust(false)
		$ExhaustSound.stop()

	_velocity.y += gravity * delta * 0.01
	var _collision = move_and_collide(_velocity)
	if _collision:
		ShipExplodes(isExploding)
		if _collision.collider.has_method("Hit"):
			_collision.collider.Hit()

func ShipExplodes(isExploding : bool) -> void:
	if not isExploding:
		setShipVisible(false)
		$ExplodeSound.play()

	$Explosion.Explode(true)

func SetShipThrusterAngle(thrust: float):
	$Thruster.rotation_degrees = thrust
	$Exhaust.SetAngle(thrust)

func setShipVisible(isVisible : bool) -> void:
	$Square.visible = isVisible
	$Thruster.visible = isVisible

	if not isVisible:
		$ExhaustSound.stop()

func _on_ExplodeSound_finished() -> void:
	_ready()
