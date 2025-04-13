extends Node2D
var blue = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Menu Buttons	
func _on_name_button_button_down() -> void:
	print(1)

func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_file("res://zone_1.tscn")

func _on_exit_button_button_down() -> void:
	get_tree().quit()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
