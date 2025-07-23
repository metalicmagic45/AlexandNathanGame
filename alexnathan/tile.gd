extends Node2D

@onready var spritetexture = $Sprite2D
@onready var tile = $Button
var grid_pos: Vector2i

var tile_size: Vector2 = Vector2(64, 64) # default fallback

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("uicancel"):
		tile.release_focus()
	
