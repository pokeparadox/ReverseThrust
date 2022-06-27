extends RigidBody2D

func _ready() -> void:
	$Animation.play("ParticleFade")

func Hit():
	queue_free()


func _on_ExhaustParticle_body_entered(_body: Node) -> void:
	queue_free()
