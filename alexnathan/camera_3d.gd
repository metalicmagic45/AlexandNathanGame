extends Camera3D

@export var min_x = -10
@export var max_x = 10
@export var max_z = 10
@export var min_z = -10
@export var speed = 5
@export var rotate = 90

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("ui_up"):
		input_dir.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir.y += 1
	if Input.is_action_pressed("ui_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_dir.x += 1

	input_dir = input_dir.normalized()

	# Convert 2D input into camera-relative 3D direction
	var basis = global_transform.basis
	var forward = -basis.y.normalized()
	var right = basis.x.normalized()

	var move_vector = (right * input_dir.x + forward * input_dir.y) * speed * delta

	var new_position = global_transform.origin + move_vector
	new_position.x = clamp(new_position.x, min_x, max_x)
	new_position.z = clamp(new_position.z, min_z, max_z)

	global_transform.origin = new_position

	# Rotation
	if Input.is_action_pressed("rotate_left"):
		rotate_y(deg_to_rad(-rotate * delta))
	if Input.is_action_pressed("rotate_right"):
		rotate_y(deg_to_rad(rotate * delta))
