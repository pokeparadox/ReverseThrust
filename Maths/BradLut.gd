extends Node

var SinCosLookup = {}
var Brad = load("Maths/Brad.gd")

func _init() -> void:
	for i in range(0, 128):
		var brad = Brad.new()
		brad.Brad(i)
		SinCosLookup[i] = sin(deg2rad(brad.GetAngleDeg()))

func SinI(a : int) -> float:
	a = wrapi(a,0,255)
	if a > 127:
		a -= 128
		return -SinCosLookup[a]

	return SinCosLookup[a]

func CosI(a : int) -> float:
	return SinI(a + 64)


func Sin(brad : Brad) -> float:
	return SinI(brad.GetAngle())


func Cos(brad : Brad) -> float:
	return CosI(brad.GetAngle())

var BradToVectorLookup = {}

func BradToVector2d(aBrad: Brad) -> Vector2:
	var a : int = aBrad.GetAngle()
	if not BradToVectorLookup.has(a):
		BradToVectorLookup[a] = Vector2(SinI(a), CosI(a))
	return BradToVectorLookup[a]
