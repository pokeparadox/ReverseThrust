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
	$Rectangle.colour = colour

func get_dimensions() -> Vector2:
	return $CollisionShape2D.shape.size

func get_half_dimensions() -> Vector2:
	return $CollisionShape2D.shape.size * 0.5

func SetDims(dims : Vector2) -> void:
	var shape = RectangleShape2D.new()
	shape.set_size(dims)
	$CollisionShape2D.shape = shape
	$LightOccluder2D.occluder = shape
	$Rectangle.set_dimensions(dims)
	$Rectangle.position = - dims * 0.5

func _on_Destructable_body_entered(body: Node) -> void:
	if not IsColliding:
		IsColliding = true
		if body.has_method("ShipExplodes"):
			body.ShipExplodes(false)
		if body.has_method("hit"):
			body.hit()
		var halfDims : Vector2 = get_half_dimensions()
		if halfDims.x < MinHalfLength and halfDims.y < MinHalfLength:
			Hit()
		else:
			emit_signal("DestructibleHit", self)
