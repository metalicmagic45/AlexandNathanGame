extends CharacterBody3D

@onready var ring = $MeshInstance3D/Ring

const GRAVITY = 9.8
var has_moved : bool = false
var ring1 : MeshInstance3D
func _ready() -> void:
	ring1 = make_ring()
	add_child(ring1)
	#var ring1_color = ring1.get_surface_override_material_count()
	#print(ring1_color, " ring1 material")
func _physics_process(delta: float) -> void:
	#Mesh acts as the frame, need to put a material over the frame, material is what stores the color or texture
	#Mesh is just a shape, material is color
	#Create mesh, create material, edit MATERUIAL albedo color
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
	var torus_material = StandardMaterial3D.new()
	#albedo_color [default: Color(1, 1, 1, 1)], set_albedo(value) setter, get_albedo() getter

	torus_material.set_albedo(Color(1, 0.270588, 0, 1))
	var torus_current_color = torus_material.get_albedo()
	print(torus_current_color, " torus material")
	
	# Set torus properties safely
	torus.set("outer_radius", 3.0)  # Outer radius
	torus.set("inner_radius", 2.99)  # Thickness of the ring
	torus.set("radial_segments", 64)
	torus.set("tubular_segments", 8)
	ring2.position.y = 0.1


	ring2.mesh = torus
	ring2.visible = false
	print(torus_current_color, " torus material")
	return ring2

	
