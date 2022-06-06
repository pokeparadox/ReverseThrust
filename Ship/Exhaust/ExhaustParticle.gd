extends RigidBody2D

func _ready() -> void:
	$Animation.play("ParticleFade")

func Hit():
	queue_free()
