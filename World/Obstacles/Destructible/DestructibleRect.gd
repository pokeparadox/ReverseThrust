extends Area2D
class_name DestructibleRect

signal DestructibleRectHit(destructible, body)

func SetDims(dims : Vector2) -> void:
	$Shape.shape.call_deferred("set_extents", dims)
	update()

func Hit() -> void:
	if not $Crumble.is_playing():
		$Crumble.play()

func _draw() -> void:
	draw_rect(Rect2($Shape.position, $Shape.shape.extents), Color.darkorange)

func _on_Crumble_finished() -> void:
	hide()
	queue_free()


func _on_Destructable_body_entered(body: Node) -> void:
	if body.has_method("ShipExplodes"):
		body.ShipExplodes(false)
	if body.has_method("Hit"):
		body.Hit()

	var dims :Vector2 = $Shape.shape.extents
	if dims <= Vector2.ONE:
		Hit()
	else:
		emit_signal("DestructibleRectHit", self, body)



