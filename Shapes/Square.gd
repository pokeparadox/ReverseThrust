extends Node2D
tool
class_name Square

export var IsFilled : bool = true setget _setIsFilled
export var LineWidth : float = 1.0 setget _setLineWidth
export var Length : float = 4.0 setget _setLength
export var Colour = Color.white setget _setColour


func _draw():
	var half : float = Length * 0.5
	draw_rect(Rect2(Vector2(-half,-half), Vector2(Length, Length)), Colour, IsFilled, LineWidth)


func _setIsFilled(value : bool):
	IsFilled = value
	update()

func _setLineWidth(value : float):
	LineWidth = value
	update()

func _setLength(value : float):
	Length = value
	update()

func _setColour(value : Color):
	Colour = value
	update()

