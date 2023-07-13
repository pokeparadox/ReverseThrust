@tool
extends EditorPlugin

const AUTOLOAD_NAME = "BradLut"

func _enter_tree():
	# Adds the B-Rad lookup tables for access in the project
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/binaryradian/BradLut.gd")


func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)
