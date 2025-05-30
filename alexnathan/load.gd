extends Control

@onready var PausePanel = $Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
func toggle_pause_menu():
	PausePanel.visible = !PausePanel.visible
func _input(event): 
	if event.is_action_pressed("uicancel"):
		toggle_pause_menu()
