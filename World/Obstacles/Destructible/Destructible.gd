extends Area2D
class_name Destructible

signal DestructibleHit(destructible)

var IsColliding : bool = false

const MinHalfLength : int = 4

func Hit() -> void:
	if not $Crumble.is_playing():
		$Crumble.play()

func _on_Crumble_finished() -> void:
	hide()
	queue_free()

func SetColour(colour : Color) -> void:
	$Square.Colour = colour

func GetLength() -> int:
	return GetHalfLength() * 2

func GetHalfLength() -> int:
	return $CollisionShape2D.shape.extents.x

func SetLength(length : int) -> void:
	var shape = RectangleShape2D.new()
	shape.set_extents(Vector2(length, length)*0.5)
	$CollisionShape2D.shape = shape
	$Square.Length = length

func _on_Destructable_body_entered(body: Node) -> void:
	if not IsColliding:
		IsColliding = true
		if body.has_method("ShipExplodes"):
			body.ShipExplodes(false)
		if body.has_method("Hit"):
			body.Hit()

		if GetHalfLength() <= MinHalfLength:
			Hit()
		else:
			emit_signal("DestructibleHit", self)
