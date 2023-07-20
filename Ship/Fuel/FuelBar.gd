extends Node2D

@export var fuel_level : float = 100.0
@export var dimensions = Vector2(150, 15)
@export var background_colour = Color(1,1,1)
@export var foreground_colour = Color(1,0,0)
@export var border_size : int = 1

func _draw():
	draw_rect(Rect2(position, dimensions), background_colour)
	var scaling : float = fuel_level/100.0
	var dims = dimensions
	dims.x = dims.x * scaling
	var offset = Vector2(border_size, border_size)
	draw_rect(Rect2(position+offset, dims-(offset*2)), foreground_colour)

func OnFuelLevelChanged(fuel):
	self.fuel_level = fuel
	self.queue_redraw()


func _on_Ship_FuelLevelChanged(fuel : float) -> void:
	OnFuelLevelChanged(fuel)
