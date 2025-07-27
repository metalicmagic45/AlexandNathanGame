extends Node3D

var is_active = false
var max_distance = 30.0
var distance_moved = 0.0
var move_speed = 5.0
var target_position : Vector3 = Vector3.ZERO
@onready var body: CharacterBody3D = $Cube_001/StaticBody3D


func move_to(position: Vector3) -> void:
	target_position = position
	distance_moved = 0.0
	is_active = true
	body.move_logic(target_position, max_distance, move_speed)
func _process(delta):
	if is_active:
		body.move_logic(target_position, max_distance, move_speed)
