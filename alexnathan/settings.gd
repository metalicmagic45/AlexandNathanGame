extends  Control

@onready var back = get_node("Panel/Button")

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://MasterScene.tscn")
