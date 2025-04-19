extends Control
@onready var sprite_2d: Sprite2D = $CenterContainer/Control/Sprite2D

func set_item(item_data):
	if item_data and item_data.has("sprite"):
		sprite_2d.texture = item_data["sprite"]
	else:
		sprite_2d.texture = null
