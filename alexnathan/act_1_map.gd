extends Control

var dragging = false
var last_mouse_pos := Vector2.ZERO

@onready var map = $Sprite2D

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		dragging = event.pressed 
		last_mouse_pos = event.position
	elif event is InputEventMouseMotion and dragging:
		var delta = event.position - last_mouse_pos
		map.position += delta
		last_mouse_pos = event.position
		_clamp_map_position()
func _clamp_map_position():
	var map_size = map.texture.get_size() * map.scale
	var view_size = size
	map.position.x = clamp(map.position.x, view_size.x - map_size.x, 0)
	map.position.y = clamp(map.position.y, view_size.y - map_size.y, 0)
	



func _on_shack_button_pressed() -> void:
	Globals.set_current_global_scene(load("res://shack.tscn"))
	get_tree().change_scene_to_file("res://MasterScene.tscn")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ToggleMasterScene"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")
