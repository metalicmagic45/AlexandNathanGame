extends Node

var players = {}

func _ready() -> void:
	players["Johnson"] = {
		"name": "Johnson",
		"sprite": preload("res://Pictures/JhonsonPortrait.png")
	}
	players["Anna"] = {
		"name": "Anna",
		"spite": preload("res://Pictures/AnnaPortrait.png")
	}
	players["Tyler"] = {
		"name": "Tyler",
		"sprite": preload("res://Pictures/TylerPortrait.png")
	}
	players["Kate"] = {
		"name": "Kate",
		"sprite": preload("res://Pictures/KatePortrait.png")
	}
