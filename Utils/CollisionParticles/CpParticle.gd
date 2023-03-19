extends RigidBody2D

signal particle_dead

var direction_vec : Vector2 = Vector2.ZERO
var position_start : Vector2 = Vector2.ZERO
var position_offset : Vector2 = Vector2.ZERO
var position_delta : Vector2 = Vector2.ZERO

func _ready() -> void:
	position_start = global_position
	$Animation.play("ParticleFade")

func set_position_offset(offset : Vector2) -> void:
	position_delta = offset - position_offset
	position_offset = offset

func _physics_process(delta):
	global_position = global_position - position_delta
	move_and_collide(direction_vec * delta)

func hit():
	visible = false
	emit_signal("particle_dead")
	queue_free()


func _on_animation_animation_finished(_anim_name):
	hit()


func _on_visible_on_screen_notifier_2d_screen_exited():
	hit()
