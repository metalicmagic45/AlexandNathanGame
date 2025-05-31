extends Control

@onready var PausePanel = $Panel


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
func toggle_pause_menu():
	PausePanel.visible = !PausePanel.visible
func _input(event): 
	if event.is_action_pressed("uicancel"):
		toggle_pause_menu()
func _on_return_button_down() -> void:
	get_tree().change_scene_to_file("res://MasterScene.tscn")
