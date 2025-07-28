extends CharacterBody3D

@onready var ring = $MeshInstance3D/Ring

const GRAVITY = 9.8
var has_moved : bool = false
var ring1 : MeshInstance3D
func _ready() -> void:
	ring1 = make_ring()
	add_child(ring1)
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = velocity.y - (GRAVITY * delta)
	else:
		velocity.y = 0
	move_and_slide()
func highlight(value : bool):
	if value == true:
		ring.visible = true
		ring1.visible = true

	else:
		ring.visible = false
		ring1.visible = false
func make_ring() -> MeshInstance3D:
	var ring2 = MeshInstance3D.new()
	var torus := TorusMesh.new()
	# Set torus properties safely
	torus.set("outer_radius", 3.0)  # Outer radius
	torus.set("inner_radius", 2.99)  # Thickness of the ring
	torus.set("radial_segments", 64)
	torus.set("tubular_segments", 8)
	ring2.position.y = 0.1


	ring2.mesh = torus
	ring2.visible = false

	return ring2

	
