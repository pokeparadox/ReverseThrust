extends Node2D

const DefaultParticles : int = 20
const MaxParticles : int = 256
const DefaultSpread : float = 2.0
const MaxSpread : float = 45.0

const LevelScaler : float = 1.05

func Reset() -> void:
	LevelUp(0)

func LevelUp(level : int):
	$ExhaustEmitter.amount = min(max(DefaultParticles, DefaultParticles * level * LevelScaler), MaxParticles)
	$ExhaustEmitter.impulse_spread_degrees = min(max(DefaultSpread, DefaultSpread + level), MaxSpread)
	$ExhaustEmitter.impulse_random = min(0.9, 0.3 + (LevelScaler/20))




func SetExhaust(exhaust : bool):
	$ExhaustEmitter.set_emitting(exhaust)

func SetAngle(angleDeg : int):
	$ExhaustEmitter.impulse_angle_degrees = angleDeg
