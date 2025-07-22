extends ColorRect

@onready var spritetexture = $Sprite2D
var grid_pos: Vector2i

var tile_size: Vector2 = Vector2(64, 64) # default fallback

func _ready():
	queue_redraw()
func _draw():
	# Black fill
	draw_rect(Rect2(Vector2.ZERO, tile_size), Color.BLACK, true)
	
	# White border
	draw_rect(Rect2(Vector2.ZERO, tile_size), Color.WHITE, false)

func apply_set_size(size: Vector2):
	tile_size = size
	self.size = size
	queue_redraw()
