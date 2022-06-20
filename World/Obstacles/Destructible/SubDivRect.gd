extends Node2D

class_name SubDivRect

var SubDividingDestructible = load("SubDividingDestructible.gd")

# An class which takes a set of rectangular dimensions and fills it with an appropriate number of subdiv blocks
func Setup(dimensions : Vector2) -> void:
	# figure out which dimension is shortest and decide to build square blocks horizontally or vertically.
	if dimensions.x > dimensions.y:
		#Build horizontally
		pass
	else:
		pass
