extends Node2D
# A Scene which detects an incoming collision and at this point increases collision complexity in that quadrant
class_name SubDividingDestructible

func Setup(length : int) -> void:
	var halfLength : int = int(length * 0.5)
	var vecHalfLength = Vector2(halfLength, halfLength)
	$TopLeft.position = -vecHalfLength
	$TopLeft.SetLength(halfLength)
	$TopRight.position = Vector2(0, -halfLength)
	$TopRight.SetLength(halfLength)
	$BottomRight.position = Vector2.ZERO
	$BottomRight.SetLength(halfLength)
	$BottomLeft.position = Vector2(-halfLength,0)
	$BottomLeft.SetLength(halfLength)

func SubDivide(length : int) -> void:
	var halfLength : int = int(length * 0.5)
	var vecHalfLength = Vector2(halfLength, halfLength)
	$TopLeft.position = -vecHalfLength
	$TopLeft.SetLength(halfLength)
	$TopRight.position = Vector2(0, -halfLength)
	$TopRight.SetLength(halfLength)
	$BottomRight.position = Vector2.ZERO
	$BottomRight.SetLength(halfLength)
	$BottomLeft.position = Vector2(-halfLength,0)
	$BottomLeft.SetLength(halfLength)

func SetPosition(pos : Vector2) -> void:
	self.position = pos

func DestructibleHit(destructible : Destructible) -> void:
	var pos : Vector2 = destructible.position
	var length : int = destructible.GetLength()
	var halfLength : int = destructible.GetHalfLength()
	destructible.queue_free()
	# Create a new SubdividingDestructible at pos with dims
	var newDestructible = load(self.filename).instance()
	#newDestructible.SetColour(Color.chartreuse)
	newDestructible.Setup(length+1)
	newDestructible.SetPosition(pos + Vector2(halfLength, halfLength) * 0.5)
	call_deferred("add_child", newDestructible)

func _on_TopLeft_DestructibleHit(destructible, _body) -> void:
	DestructibleHit(destructible)


func _on_TopRight_DestructibleHit(destructible, _body) -> void:
	DestructibleHit(destructible)


func _on_BottomLeft_DestructibleHit(destructible, _body) -> void:
	DestructibleHit(destructible)


func _on_BottomRight_DestructibleHit(destructible, _body) -> void:
	DestructibleHit(destructible)
