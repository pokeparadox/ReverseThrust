extends Node2D

@export var FuelLevel : float = 100.0
@export var Dimensions = Vector2(150, 15)
@export var BackgroundColour = Color(1,1,1)
@export var ForegroundColour = Color(1,0,0)
@export var BorderSize : int = 1

func _draw():
	draw_rect(Rect2(position, Dimensions), BackgroundColour)
	var scaling : float = FuelLevel/100.0
	var dims = Dimensions
	dims.x = dims.x * scaling
	var offset = Vector2(BorderSize, BorderSize)
	draw_rect(Rect2(position+offset, dims-(offset*2)), ForegroundColour)

func OnFuelLevelChanged(fuel):
	self.FuelLevel = fuel
	self.queue_redraw()


func _on_Ship_FuelLevelChanged(fuel : float) -> void:
	OnFuelLevelChanged(fuel)
