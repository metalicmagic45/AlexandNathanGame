extends Control

@onready var Itemlist = $TextureRect/VBoxContainer/HBoxContainer/ItemList
@onready var label = $TextureRect/VBoxContainer/HBoxContainer/Panel/Label


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
	for note_id in notes:
		var note = notes[note_id]
		item_list.add_item(note["title"])
		item_list.set_item_metadata(item_list.item_count - 1, note_id)



func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var notes = Journal.get_journal()
	var note_id = Itemlist.get_item_metadata(index)
	var note = notes[note_id]
	label.text = note["description"]
