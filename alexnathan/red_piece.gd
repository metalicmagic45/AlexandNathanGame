extends CharacterBody3D

@onready var ring = $MeshInstance3D/Ring

const GRAVITY = 9.8
var has_moved : bool = false
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = velocity.y - (GRAVITY * delta)
	else:
		velocity.y = 0
	move_and_slide()
func highlight(value : bool):
	if value == true:
		ring.visible = true
	else:
		ring.visible = false
