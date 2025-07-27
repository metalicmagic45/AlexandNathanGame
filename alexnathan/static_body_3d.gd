# characterbody3d.gd
extends CharacterBody3D

const GRAVITY = 9.81
var input_velocity_h = Vector3.ZERO # New variable for horizontal input velocity

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y -= GRAVITY * delta
	else:
		velocity.y = 0

	# Add horizontal movement calculated from move_logic
	velocity.x = input_velocity_h.x
	velocity.z = input_velocity_h.z

	# Move the character
	move_and_slide()

func move_logic(target : Vector3, max_distance, move_speed):
	var direction = (target - global_transform.origin)
	var distance = direction.length()
	if distance > 0.1:
		direction = direction.normalized()
		var movement = direction * move_speed * get_physics_process_delta_time()
		if movement.length() > max_distance:
			movement = movement.normalized() * max_distance
		input_velocity_h = movement
	
	
	
