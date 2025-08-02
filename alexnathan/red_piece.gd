extends CharacterBody3D

@onready var ring = $MeshInstance3D/Ring
var current_weapon = ItemDatabase.get_item("HIPower")
const GRAVITY = 9.8
var has_moved : bool = false
var ring1 : MeshInstance3D
var name_id = "test2"
var HP_MAX = 10
var HP = 10
var MP_MAX = 10
var MP = 10
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
	#Material vs Mesh*****
	#Mesh acts as the frame, need to put a material over the frame, material is what stores the color or texture
	#Mesh is just a shape, material is color
	#Create mesh, create material, edit MATERUIAL albedo color
	
	#Alebedo_color and material assignment*****
	#List of color id's can be found in the color documentation page, use the documentation window inside godot for color preview
	#albedo_color [default: Color(1, 1, 1, 1)], set_albedo(value) setter, get_albedo() getter
	#Have to use set_material for torus meshes' and set_surface_override_material for MeshInstance3D
	#torus meshes use diffrent type of mesh called primative mesh
	#set_material just takes 1 aurgument for the material, set_surface_override_material takes 2 one for the surface and the other for the material
	
	var ring2 = MeshInstance3D.new()
	var torus := TorusMesh.new()
	var torus_material = StandardMaterial3D.new()

	torus_material.set_albedo(Color(1, 0.270588, 0, 1))
	torus.set_material(torus_material)
	#var torus_current_color = torus_material.get_albedo()
	#print(torus_current_color, " torus material")
	
	# Set torus properties safely
	torus.set("outer_radius", 3.0)  # Outer radius
	torus.set("inner_radius", 2.99)  # Thickness of the ring
	torus.set("radial_segments", 64)
	torus.set("tubular_segments", 8)
	ring2.position.y = 0.1


	ring2.mesh = torus
	ring2.visible = false
	
	return ring2
func access_weapon():
	return current_weapon

	
	
