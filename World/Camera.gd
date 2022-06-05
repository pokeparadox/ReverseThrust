extends Camera2D

func _physics_process(_delta: float) -> void:
	position.y = get_node("../Ship").position.y
