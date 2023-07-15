extends Node2D

var Brad = load("res://addons/binaryradian/Brad.gd")
@export var emitting : bool = true
@export var max_particles : int = 512
@export var spread : int = 0
@export var angle_brads : int = 64
@export var speed : float = 100
@export var delay : float = 0.032
var num_particles : int = 0
var cumulative_delta : float = 0
var angle_b : Brad

func _ready():
	angle_b = Brad.new()

func _physics_process(delta):
	cumulative_delta += delta
	if cumulative_delta > delay:
		cumulative_delta = 0
		spawn_particle()
		
	for p in get_children():
		p.set_position_offset(global_position)
	
func on_particle_dead():
	num_particles -= 1
		
func spawn_particle():
	if emitting and num_particles < max_particles:
		var p = load("res://Utils/CollisionParticles/CpParticle.tscn").instantiate()
		angle_b.set_angle(Random.next_int_range(angle_brads - spread,  angle_brads + spread)) 
		p.direction_vec = BradLut.brad_to_vector_2d(angle_b) * speed
		p.direction_vec.x = -p.direction_vec.x	
		p.connect("particle_dead", on_particle_dead)
		p.global_position = Vector2.ZERO
		add_child(p)
		num_particles += 1
