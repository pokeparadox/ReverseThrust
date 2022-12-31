extends Node2D

export var default_particles : int = 30
export var max_particles : int = 256
export var default_spread : float = 2.0
export var max_spread : float = 30.0
export var level_scaler : float = 0.8

var level : int = 0

func reset() -> void:
	_set_level(0)


func level_up() -> void:
	_set_level(level + 1)


func set_exhaust(exhaust : bool) -> void:
	$ExhaustEmitter.set_emitting(exhaust)


func set_angle(angleDeg : int) -> void:
	$ExhaustEmitter.impulse_angle_degrees = angleDeg


func _set_level(l : int) -> void:
	level = l
	$ExhaustEmitter.amount = min(max(default_particles, default_particles * level * level_scaler), max_particles)
	$ExhaustEmitter.impulse_spread_degrees = min(max(default_spread, default_spread + level), max_spread)
	$ExhaustEmitter.impulse_random = min(0.9, 0.3 + (level_scaler/20))	
