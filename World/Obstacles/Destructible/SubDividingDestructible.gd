extends Node2D
# A Scene which detects an incoming collision and at this point increases collision complexity in that quadrant
class_name SubDividingDestructible

var IsHitting : bool = false
const MaxLength : int = 300
var colour : Color

func setup(length : int, c : Color) -> void:
	colour = c
	length = int(min(MaxLength, length))
	var halfLength : int = int(length * 0.5)
	var vecHalfLength = Vector2(halfLength, halfLength)
	$TopLeft.position = -vecHalfLength
	$TopLeft.SetLength(halfLength)
	$TopLeft.SetColour(c)
	$TopRight.position = Vector2(0, -halfLength)
	$TopRight.SetLength(halfLength)
	$TopRight.SetColour(c)
	$BottomRight.position = Vector2.ZERO
	$BottomRight.SetLength(halfLength)
	$BottomRight.SetColour(c)
	$BottomLeft.position = Vector2(-halfLength,0)
	$BottomLeft.SetLength(halfLength)
	$BottomLeft.SetColour(c)

func set_colour(c : Color) -> void:
	colour = c

func SetPosition(pos : Vector2) -> void:
	self.position = pos

func DestructibleHit(destructible : Destructible) -> void:
	if IsHitting:
		return

	IsHitting = true
	var pos : Vector2 = destructible.position
	var length : int = destructible.GetLength()
	var halfLength : int = destructible.GetHalfLength()
	destructible.queue_free()
	# Create a new SubdividingDestructible at pos with dims
	var newDestructible = load(self.filename).instance()
	newDestructible.setup(length+1, colour)
	newDestructible.SetPosition(pos + Vector2(halfLength, halfLength) * 0.5)
	call_deferred("add_child", newDestructible)
	IsHitting = false

func _on_TopLeft_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)


func _on_TopRight_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)


func _on_BottomLeft_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)


func _on_BottomRight_DestructibleHit(destructible) -> void:
	DestructibleHit(destructible)
