class_name Ship
extends CharacterBody2D

var Brad = load("res://addons/binaryradian/Brad.gd")

signal FuelLevelChanged(fuelLevel)

@onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
@onready var screenRes : Vector2 = Resolution.get_resolution()

var shipHeading : Brad
const ROTATE_SPEED : int = 200
const THRUST_SPEED : int = 20
const MAX_THRUST_SQ : int = 800
var highestHeight : int = 0
var Fuel : float = 100.0


var _velocity = Vector2.ZERO

func _init():
	shipHeading = Brad.new()

func _ready() -> void:
	_velocity = Vector2.ZERO
	self.position = screenRes * 0.5
	shipHeading.set_angle(0)
	$Exhaust.set_exhaust(false)
	$Exhaust.visible = false
	$Explosion.Explode(false)
	setShipVisible(true)

func _physics_process(delta):
	var isExploding = $ExplodeSound.is_playing()
	$Exhaust.visible = not isExploding
	if isExploding:
		return

	var rot = -(Input.get_action_strength("RotateLeft") - Input.get_action_strength("RotateRight"))
	shipHeading = shipHeading.add_angle(rot * delta * ROTATE_SPEED)
	SetShipThrusterAngle(shipHeading.get_angle_deg())

	if Input.is_action_pressed("Thrust"):
		var vec : Vector2 = BradLut.brad_to_vector_2d(shipHeading)
		if _velocity.length_squared() < MAX_THRUST_SQ:
			vec = vec * delta * THRUST_SPEED
			vec.y = -vec.y
			if vec.y > 0:
				vec.y = vec.y * 0.5
			_velocity += vec
		if Fuel >= 0:
			Fuel -= delta * 2
			emit_signal("FuelLevelChanged", Fuel)
		$Exhaust.set_exhaust(true)
		if not $ExhaustSound.is_playing():
			$ExhaustSound.play()
	else:
		_velocity *= 0.99
		$Exhaust.set_exhaust(false)
		$ExhaustSound.stop()

	_velocity.y += gravity * delta * 0.01
	var _collision = move_and_collide(_velocity)
	if _collision:
		ShipExplodes(isExploding)
		if _collision.get_collider().has_method("Hit"):
			_collision.get_collider().Hit()
	if position.y < highestHeight:
		highestHeight = int(position.y) -100

func ShipExplodes(exploding : bool) -> void:
	if not exploding:
		setShipVisible(false)
		$ExplodeSound.play()
		$Exhaust.reset()

	$Explosion.Explode(true)

func SetShipThrusterAngle(thrust: float):
	$Thruster.rotation_degrees = thrust
	$Exhaust.set_angle(thrust)

func setShipVisible(isVisible : bool) -> void:
	$Square.visible = isVisible
	$Thruster.visible = isVisible

	if not isVisible:
		$ExhaustSound.stop()

func _on_ExplodeSound_finished() -> void:
	_ready()
	position.y = highestHeight + 50


func _on_FuelBar_FuelLevelChanged() -> void:
	pass # Replace with function body.
