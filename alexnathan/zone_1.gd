extends Node2D

@onready var PauseLayer = $PauseLayer
@onready var PausePanel = $PauseLayer/Panel



func _input(event): 
	if event.is_action_pressed("uicancel"):
		toggle_pause_menu()
func toggle_pause_menu():
	PausePanel.visible = !PausePanel.visible

			
		


func _on_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
# Replace with function body.
