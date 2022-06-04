extends Node2D
tool
class_name Line

export var LineWidth : float = 1.0 setget _setLineWidth
export var Length : float = 400.0 setget _setLength
export var Colour = Color.white setget _setColour


func _draw():
	draw_line(Vector2.ZERO ,Vector2(0, Length),Colour, LineWidth)

func _setLineWidth(value:float):
	LineWidth = value
	update()

func _setLength(value:float):
	Length = value
	update()

func _setColour(value:Color):
	Colour = value
	update()
