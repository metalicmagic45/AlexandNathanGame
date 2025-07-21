extends  Control

@onready var back = get_node("Panel/Button")
@onready var panel = $Panel/Panel/VBoxContainer/Control2/HBoxContainer/Control/Panel/Label
@onready var itemlist = $Panel/Panel/VBoxContainer/Control2/HBoxContainer/ItemList
func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://MasterScene.tscn")
var textdata = {
	"Space": "The space button will progress through the text and dialogue.",
	"M-Key": "The M-Key activates the magic menu.",
	"N-Key": "The N-Key activates the journal menu.",
	"Ctrl+M": "This key can be used in the load menu to go back to the gameplay scene.",
	"Esc": "This key can activate the pause menu in the gameplayscene. In other scenes, it can be used to exit menus.",
	"C-Key": "The C-Key activates the character menu to view stats and info.",
	"I-Key": "The I-Key opens the inventory menu."
}


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var key = itemlist.get_item_text(index)
	var text = textdata.get(key, "Not Found")
	panel.text = text
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("uicancel"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")
