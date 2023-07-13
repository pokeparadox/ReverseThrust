class_name Brad
extends Node

# A B-Rad is a measure of angles, traditionally used for 8bit retro games programming to take advantage of the natural wrapping of 
# an unsigned byte and avoid float calculations 
# This class aims to emulate that behaviour to aid in porting over code that may use Brads.
# Class by PokeParadox ported from original C++ in Penjin

const MAX_VALUE: int = 255

var angle: int = 0 : set = set_angle

func brad(brad_angle: int):
	set_angle(brad_angle)
	return self


func brad_deg(deg: float):
	set_angle_deg(deg)
	return self


func brad_rad(rad: float):
	set_angle_rad(rad)
	return self


func set_angle(brad_angle: int):
	angle = wrapi(brad_angle, 0, MAX_VALUE)


func set_angle_deg(deg: float):
	deg = wrapf(deg, 0, 359)
	set_angle(int(deg * 32 * 0.02222222))


func set_angle_rad(rad: float):
	set_angle_deg(rad * PI * 0.005555556)


func get_angle() -> int:
	return angle


func get_angle_deg() -> float:
	return angle * 45 * 0.03125


func get_angle_rad() -> float:
	return deg_to_rad(get_angle_deg())


func equals(other: Brad) -> bool:
	return angle == other.angle


func greater_than(other: Brad) -> bool:
	return angle > other.angle


func less_than(other: Brad) -> bool:
	return angle < other.angle


func greater_than_or_equal(other: Brad) -> bool:
	return angle >= other.angle


func less_than_or_equal(other: Brad) -> bool:
	return angle <= other.angle


func add(other: Brad) -> Brad:
	set_angle(angle + other.get_angle())
	return self


func add_angle(brad_angle: int) -> Brad:
	return brad(angle + brad_angle)


func add_angle_deg(deg: float) -> Brad:
	return brad_deg(get_angle_deg() + deg)


func add_angle_rad(rad: float) -> Brad:
	return brad_rad(get_angle_rad() + rad)


func subtract(other: Brad) -> Brad:
	return brad(angle - other.angle)


func subtract_angle(brad_angle: int) -> Brad:
	return brad(angle - brad_angle)


func subtract_angle_deg(deg: float) -> Brad:
	return brad_deg(get_angle_deg() - deg)


func subtract_angle_rad(rad: float) -> Brad:
	return brad_rad(get_angle_rad() - rad)


func increment() -> void:
	angle += 1


func decrement() -> void:
	angle -= 1


func increment_assign() -> Brad:
	increment()
	return self


func decrement_assign() -> Brad:
	decrement()
	return self
