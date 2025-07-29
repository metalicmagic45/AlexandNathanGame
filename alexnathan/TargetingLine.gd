extends Node3D

var start_pos: Vector3
var end_pos: Vector3
var mesh_instance: MeshInstance3D

func _ready():
	mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = ImmediateMesh.new()
	add_child(mesh_instance)

func update_line(from: Vector3, to: Vector3):
	start_pos = from
	end_pos = to
	draw_line()

func draw_line():
	var mesh := mesh_instance.mesh as ImmediateMesh
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	mesh.surface_add_color(Color(1, 0, 0))
	mesh.surface_add_vertex(start_pos)
	mesh.surface_add_color(Color(1, 0, 0))
	mesh.surface_add_vertex(end_pos)
	mesh.surface_end()
