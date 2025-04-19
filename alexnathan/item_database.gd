extends Node

var items = {}

func _ready() -> void:
	items["colt1911"] = {
		"name": "Colt 1911",
		"sprite": preload("res://Pictures/1911colt.png"),		
	}
	items["berettaM9"] = {
		"name": "Beretta M9",
		"sprite": preload("res://Pictures/m9.png")
	}
	items["HIPower"] = {
		"name": "Hi-Power",
		"sprite": preload("res://Pictures/HiPower.png")
	}
	items["Glock17"] = {
		"name": "Glock 17",
		"sprite": preload("res://Pictures/g17.png")
	}
	items["m14"] = {
		"name": "M14",
		"sprite": preload("res://Pictures/m14.png")
	}
	items["axe"] = {
		"name": "Axe",
		"sprite": preload("res://Pictures/axe.png")
	}
