extends Node

var rand = RandomNumberGenerator.new()
var max_value = 1
var min_value = 0

func set_limits(min_v,  max_v) -> void:
	max_value = max_v
	min_value = min_v


func next_float() -> float:
	return randf_range(min_value, max_value)


func next_int() -> int:
	return rand.randi_range(min_value, max_value)


func next_float_range(min_v, max_v) -> float:
	return randf_range(min_v, max_v)


func next_int_range(min_v, max_v) -> int:
	return rand.randi_range(min_v, max_v)


func next_bool() -> bool:
	if rand.randi_range(0, 1) == 1:
		return true
	else:
		return false


func _ready():
	randomize()
	rand.randomize()

