extends Node2D

func Reset() -> void:
	$AudioStreamPlayer.play()
	$DestructibleBlock.Reset()
