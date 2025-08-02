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
var line = Area3D.new()
var targeting_active = false

#gas station is about 9.6 x 6
var is_targeting: bool = false
var targeting_line: Node3D
var targeting_weapon
var mouse_pos
func _ready() -> void:
	redpiece.add_to_group("units")
	bluepiece.add_to_group("units")
	turn_order = [bluepiece, redpiece]
	current_piece = turn_order[0]
	current_piece.highlight(true)
	populate_turnorder()
	highlight_text(turn_index)
func _process(delta: float) -> void:
	if is_targeting:
		var space_state = get_world_3d().direct_space_state
		var mouse_2d = get_viewport().get_mouse_position()
		var ray_origin = camera3d.project_ray_origin(mouse_2d)
		var ray_normal = camera3d.project_ray_normal(mouse_2d)
		var ray_end = ray_origin + ray_normal * 100
		var query = PhysicsRayQueryParameters3D.create(ray_origin,ray_end)

		var result = space_state.intersect_ray(query)
		if result and result.has("position"):
			var base = current_piece.global_transform.origin
			base.y = 0.3  
			mouse_pos = result.position
			var origin = current_piece.global_transform.origin
			var direction = (mouse_pos - origin)
			var max_range = targeting_weapon["range"]
			var length = min(direction.length(), max_range)
			# Set line base position
			line.global_transform.origin = base

			# Rotate the line to face cursor
			line.look_at(mouse_pos)
		

			# Adjust mesh to point forward from origin
			for child in line.get_children():
				if child is MeshInstance3D and child.mesh is CylinderMesh:
					child.mesh.height = length
					child.position = Vector3(0, 0, -length / 2.0)

				
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_targeting:
		var mouse_position = event.position
		var ray_origin = camera3d.project_ray_origin(mouse_position)
		var ray_normal = camera3d.project_ray_normal(mouse_position)

		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_origin + ray_normal * 100 )
		var result = space_state.intersect_ray(query)

		if result and result.has("collider"):
			var clicked = result.collider

			# Traverse up to root if you hit a Mesh or CollisionShape
			while clicked and not clicked.is_in_group("units"):
				clicked = clicked.get_parent()
			if clicked and clicked.is_in_group("units"):
				print("Clicked unit: ", clicked.name)
				var damage = Combat.roll_item_damage(targeting_weapon["dmg"])
			else:
				print("Hit something, but not a unit")
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_targeting == false:
		var hovered = get_viewport().gui_get_hovered_control()
		if hovered and hovered != $CanvasLayer/Control:
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
				if is_instance_valid(line):
					line.queue_free()
				line = Area3D.new()
				is_targeting = false
				targeting_active = false
				current_piece = turn_order[turn_index]
				current_piece.highlight(true)
				highlight_text(turn_index)
				turn_count += (1/turn_order.size())
	if event.is_action_pressed("uicancel") and is_targeting == true:
		line.queue_free()
		is_targeting = false
		targeting_active = false 
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
func weapon_targeting(weapon, range):
	is_targeting = true
	targeting_active = true
	targeting_weapon = weapon
	
	# Create line holder node and position it at the current_piece's origin
	line = Area3D.new()
	line.global_transform = current_piece.global_transform

	# Create mesh
	var mesh_instance = MeshInstance3D.new()
	var cylinder_mesh = CylinderMesh.new()
	cylinder_mesh.top_radius = 0.01
	cylinder_mesh.bottom_radius = 0.01
	cylinder_mesh.height = range
	cylinder_mesh.radial_segments = 10
	mesh_instance.mesh = cylinder_mesh

	# Material
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(1, 0, 0)
	mesh_instance.material_override = material

	# Position mesh so base is at origin (extend along +Z)
	mesh_instance.rotation_degrees.x = 90

	# Collision shape
	var collision = CollisionShape3D.new()
	var shape = CylinderShape3D.new()
	shape.radius = 0.01
	shape.height = range
	collision.shape = shape
	collision.rotation_degrees.x = 90

	# Add to line
	line.add_child(mesh_instance)
	line.add_child(collision)

	add_child(line)

	
func _on_weapon_pressed() -> void:
	if targeting_active == true:
		return
	else:
		var weapon = current_piece.access_weapon()
		weapon_targeting(weapon, weapon["range"])
	

func _on_reaction_pressed() -> void:
	pass # Replace with function body.


func _on_guard_pressed() -> void:
	pass # Replace with function body.
