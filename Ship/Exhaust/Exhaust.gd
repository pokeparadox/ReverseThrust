extends Node2D

@export var default_particles : int = 100
@export var max_particles : int = 2000
@export var default_spread : float = 2.0
@export var max_spread : float = 45.0
@export var level_scaler : float = 0.4

var level : int = 0

func reset() -> void:
	_set_level(0)


func level_up() -> void:
	_set_level(level + 1)


func _process(_delta):
	$CpEmitter.global_position = global_position

func set_exhaust(exhaust : bool) -> void:
	$GPUParticles2D.set_emitting(exhaust)
	$CpEmitter.emitting = exhaust


func set_angle(angle_deg : int) -> void:
	$CpEmitter.angle_brads = BradLut.deg_to_brad(angle_deg)
	var proc_mat : ParticleProcessMaterial = $GPUParticles2D.process_material
	if proc_mat:
		var vec2 : Vector2 = BradLut.brad_val_to_vector_2d($CpEmitter.angle_brads-64)
		proc_mat.direction = Vector3(-vec2.x, vec2.y, 0)
		$GPUParticles2D.process_material = proc_mat

func _set_level(l : int) -> void:
	level = l
	$CpEmitter.max_particles = min(max(default_particles, default_particles * level * level_scaler), max_particles)
	$GPUParticles2D.amount = $CpEmitter.max_particles * 0.75
	$GPUParticles2D.randomness = min(0.9, 0.3 + (level_scaler/20))
	$CpEmitter.spread = (l + 3) * 0.25
	
