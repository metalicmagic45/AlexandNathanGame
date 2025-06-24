extends Control

@onready var Itemlist = $TextureRect/VBoxContainer/HBoxContainer/ItemList


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("NotesToggle"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_list()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func populate_list():
	var item_list = Itemlist
	item_list.clear()
	var notes = Journal.get_journal()
	for item_name in notes:
		item_list.add_item(item_name)
