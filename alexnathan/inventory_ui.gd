extends Control	
@onready var grid_container: GridContainer = $VBoxContainer/GridContainer
@onready var itemcontainerscene = preload("res://inventory_slot.tscn")
@onready var itemlist = $VBoxContainer/Control/HBoxContainer/ItemList
@onready var sprite = $VBoxContainer/Control/HBoxContainer/Control/VBoxContainer/Panel/CenterContainer/TextureRect
@onready var text_label = $VBoxContainer/Control/HBoxContainer/Control/VBoxContainer/Panel2/Label

func _input(event):
	if event.is_action_pressed("ToggleInvetory"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")
	if event.is_action_pressed("uicancel"):
		deselect_all()
func reset():
	for child in itemlist.get_children():
		child.queue_free()
func add_item(item : String):
	var inventoryslot = itemcontainerscene.instantiate()
	grid_container.add_child(inventoryslot)
	var item_data = ItemDatabase.items.get(item)
	inventoryslot.set_item(item, item_data)
func load_player_inventory(player : String):
	reset()
	var data = Playerinventory.get_inventory(player)
	for item : String in data: 
		add_item(item)
func _ready():
	populate_list()
func populate_list():
	itemlist.clear()
	var item_ids = Playerinventory.get_inventory("William Clark")
	for i in item_ids:
		var item = ItemDatabase.items.get(i)
		if item.has("name"):
			itemlist.add_item(item["name"])
func get_id_from_name(target_name: String) -> String:
	for id in ItemDatabase.items.keys():
		if ItemDatabase.items[id].has("name") and ItemDatabase.items[id]["name"] == target_name:
			return id
	return ""
func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var name = itemlist.get_item_text(index)
	var id = get_id_from_name(name)
	sprite.texture = ItemDatabase.items[id]["sprite"]
	var text_data = ItemDatabase.items[id]["text"]
	text_label.text = text_data
func deselect_all():
	itemlist.deselect_all()
	sprite.texture = null  # Also clear sprite if you want to show "nothing selected"
	text_label.text = ""
	
