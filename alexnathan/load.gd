extends Control

@onready var PausePanel = $Panel
@onready var title1 = $HBoxContainer/Save1/CenterContainer/VBoxContainer/Title
@onready var title2 = $HBoxContainer/Save2/CenterContainer/VBoxContainer/Title
@onready var title3 = $HBoxContainer/Save3/CenterContainer/VBoxContainer/Title
@onready var title4 = $HBoxContainer/Save4/CenterContainer/VBoxContainer/Title
@onready var title5 = $HBoxContainer/Save5/CenterContainer/VBoxContainer/Title
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
func toggle_pause_menu():
	PausePanel.visible = !PausePanel.visible
func _input(event): 
	if event.is_action_pressed("uicancel"):
		toggle_pause_menu()
func _on_return_button_down() -> void:
	get_tree().change_scene_to_file("res://MasterScene.tscn")
