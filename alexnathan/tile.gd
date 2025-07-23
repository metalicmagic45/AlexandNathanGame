extends Node2D

@onready var spritetexture = $Sprite2D
@onready var tile = $Button
var grid_pos: Vector2i

var tile_size: Vector2 = Vector2(64, 64) # default fallback

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("uicancel"):
		tile.release_focus()
func _draw():
	var outline_offset = Vector2(-32, -32)
	var outline_rect = Rect2(outline_offset, tile_size)
	var thickness = 1.0

	draw_rect(outline_rect, Color.WHITE, false, thickness)
