extends Area2D

func Hit() -> void:
	if not $Crumble.is_playing():
		$Crumble.play()



func _on_Crumble_finished() -> void:
	hide()
	queue_free()


func _on_Destructable_body_entered(body: Node) -> void:
	if body.has_method("ShipExplodes"):
		body.ShipExplodes(false)
	Hit()
