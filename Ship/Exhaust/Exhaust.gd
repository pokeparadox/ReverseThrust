extends Node2D

func SetExhaust(exhaust : bool):
	visible = exhaust
	$ExhaustEmitter.set_emitting(exhaust)

func SetAngle(angleDeg : int):
	$ExhaustEmitter.impulse_angle_degrees = angleDeg
