extends Node3D

@onready var camera3d = $Camera3D
@onready var redpiece = $Red
@onready var bluepiece = $Blue
@onready var turnorderbar = $CanvasLayer/Control/TurnOrder
var max_distance = 3

var turn_order = []
var turn_index = 0
var turn_count = 0
var current_piece 
var temp : bool = false
#gas station is about 9.6 x 6

func _ready() -> void:
	turn_order = [bluepiece, redpiece]
	current_piece = turn_order[0]
	current_piece.highlight(true)
	populate_turnorder()
	highlight_text(turn_index)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_viewport().gui_get_hovered_control():
			return
		var mouse_position = event.position
		var ray_origin = camera3d.project_ray_origin(mouse_position)
		var ray_normal = camera3d.project_ray_normal(mouse_position)
		
		var space_state = get_world_3d().direct_space_state
		var ray_length = 100.0
		var query = PhysicsRayQueryParameters3D.create(
			ray_origin,
			ray_origin + ray_normal * ray_length
		)
		var result = space_state.intersect_ray(query)
		if result and result.has("position"):
			var hit_position = result.position
			temp = transport(current_piece, hit_position)
			if temp == false:
				return
			else:
				unhighlight_text(turn_index)
				turn_index = (turn_index + 1) % turn_order.size()
				current_piece.highlight(false)
				current_piece = turn_order[turn_index]
				current_piece.highlight(true)
				highlight_text(turn_index)
				turn_count += (1/turn_order.size())
func transport(piece, hit_position: Vector3, test_margin := -0.01, max_allowed_collisions := 1) -> bool:
	var origin = piece.global_transform.origin
	var distance = origin.distance_to(hit_position)
	var distance_y = abs(origin.y - hit_position.y)
	if (distance > max_distance) or (distance_y > 0.1):
		return false
	if tp_boundary(hit_position) == false:
		return false
	else:
		piece.global_transform.origin = hit_position
		return true
func tp_boundary(pos : Vector3) -> bool:
	return(pos.x >= -5.5 and pos.x <= 4.1 and pos.z >= -2.8 and pos.z <= 3)
func populate_turnorder():
	for child in turnorderbar.get_children():
		child.queue_free()
	for i in range(turn_order.size()):
		var piece = turn_order[i]
		var label = Label.new()
		var slot = Panel.new()
		slot.set_custom_minimum_size(Vector2(75, 10))
		label.text = piece.name
		slot.add_child(label)
		turnorderbar.add_child(slot)	
func highlight_text(turnindex):
	var slot = turnorderbar.get_child(turnindex)
	var label = slot.get_child(0)
	label.add_theme_color_override("font_color", Color(0,1,0))
func unhighlight_text(turnindex):
	var slot = turnorderbar.get_child(turnindex)
	var label = slot.get_child(0)
	label.add_theme_color_override("font_color", Color(1,1,1))
	
	
	

	
