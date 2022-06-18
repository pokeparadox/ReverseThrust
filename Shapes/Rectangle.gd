extends Node2D
tool
class_name Rectangle

export var IsFilled : bool = true setget _setIsFilled
export var LineWidth : float = 1.0 setget _setLineWidth
export var Width : float = 4.0 setget _setWidth
export var Height : float = 4.0 setget _setHeight
export var Colour = Color.white setget _setColour


func _draw():
	var dims = Vector2(Width, Height)
	#var halfVec = dims * 0.5
	draw_rect(Rect2(Vector2.ZERO, dims), Colour, IsFilled, LineWidth)

func _setIsFilled(value : bool):
	IsFilled = value
	update()

func _setLineWidth(value : float):
	LineWidth = value
	update()

func _setWidth(w : float):
	Width = w
	update()

func _setHeight(h : float):
	Height = h
	update()

func _setColour(c : Color):
	Colour = c
	update()
