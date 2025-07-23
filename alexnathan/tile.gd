extends ColorRect

@onready var spritetexture = $Sprite2D
@onready var tile = $Button
var grid_pos: Vector2i

var tile_size: Vector2 = Vector2(64, 64) # default fallback

func _ready():
	queue_redraw()
func _draw():
	# Black fill
	draw_rect(Rect2(Vector2.ZERO, tile_size), Color.BLACK, true)
	
	# White border
	draw_rect(Rect2(Vector2.ZERO, tile_size), Color.WHITE, false)
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("uicancel"):
		tile.release_focus()
	
