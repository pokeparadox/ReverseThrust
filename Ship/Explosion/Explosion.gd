extends Node2D

func Explode(exploding : bool):
	$ExplosionEmit.set_emitting(exploding)
	$ExplosionEmit.visible = exploding

