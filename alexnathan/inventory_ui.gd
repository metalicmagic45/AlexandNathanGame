extends Control	
@onready var grid_container: GridContainer = $VBoxContainer/GridContainer
@onready var itemcontainerscene = preload("res://inventory_slot.tscn")

func _input(event):
	if event.is_action_pressed("ToggleInvetory"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")

func reset():
	for child in grid_container.get_children():
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
	reset()
	load_player_inventory("William Clark")
