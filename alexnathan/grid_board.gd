extends Node2D

const GRID_SIZE = Vector2i(10, 10)
const TILE_SIZE = 64


@onready var TileScene = preload("res://tile.tscn")

func _ready():
	create_tiles()
func create_tiles():
	var viewport_size = get_viewport_rect().size
	var total_grid_size = Vector2(GRID_SIZE.x * TILE_SIZE, GRID_SIZE.y * TILE_SIZE)
	var offset = (viewport_size - total_grid_size) / 2

	for x in GRID_SIZE.x:
		for y in GRID_SIZE.y:
			var tile = TileScene.instantiate()
			tile.grid_pos = Vector2i(x, y)
			tile.position = offset + Vector2(x * TILE_SIZE, y * TILE_SIZE)
			tile.apply_set_size(Vector2(TILE_SIZE, TILE_SIZE))
			add_child(tile)
