extends Node2D

func SetExhaust(exhaust : bool):
	$ExhaustEmitter.set_emitting(exhaust)
#	if exhaust and not $ExhaustSound.is_playing():
#		$ExhaustSound.play()
#	else:
#		$ExhaustSound.stop()

func SetAngle(angleDeg : int):
	$ExhaustEmitter.force_angle_degrees = angleDeg
