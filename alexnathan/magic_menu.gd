extends Control

@onready var magicrect = $Panel/ContainerBase/ItemControl/VBoxContainer/ItemDisplayControl/CenterContainer/Panel/CenterContainer/MagicItemDisplay
@onready var Itemlist = $Panel/ContainerBase/ItemControl/VBoxContainer/ItemInfoControl/CenterContainer/Panel/CenterContainer/ItemList
@onready var ActiveAbilityText = $Panel/ContainerBase/ItemDataControl/VBoxContainer/Active/CenterContainer/Panel/CenterContainer/RichTextLabel
@onready var PassiveAbilityText = $Panel/ContainerBase/ItemDataControl/VBoxContainer/Passive/CenterContainer/Panel/CenterContainer/RichTextLabel
@onready var deslect = $Panel/ContainerBase/ItemControl/VBoxContainer/ItemDisplayControl/CenterContainer/Panel/Deslected
var current_index = Globals.get_current_magic_index()
var current_magic_item = Globals.get_current_magic_item()
# Called when the node enters the scene tree for the first time.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ToggleMagic"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")
func _ready() -> void:
	populate_list()
	if current_magic_item != null:
		current_index = find_item_index(current_magic_item)
		Itemlist.select(current_index)
		_on_item_list_item_selected(current_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func populate_list():
	var item_list = Itemlist
	item_list.clear()
	var magic_items = Playerinventory.get_magic_items()
	for item_name in magic_items:
		item_list.add_item(item_name)
func find_item_index(target_item: Dictionary) -> int:
	for i in Itemlist.item_count:
		var name = Itemlist.get_item_text(i)
		if ItemDatabase.items.has(name) and ItemDatabase.items[name] == target_item:
			return i
	return -1
	
func _on_deslected_pressed() -> void:
	if current_index == -1:
		deslect.release_focus()
		return
	magicrect.texture = null
	ActiveAbilityText.text = ""
	PassiveAbilityText.text = ""
	Itemlist.deselect(current_index)
	current_index = -1
	Globals.set_current_magic_index(current_index)
	Globals.set_current_magic_item(null)
	deslect.release_focus()  
func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if mouse_button_index == MOUSE_BUTTON_LEFT:
		var item_name = Itemlist.get_item_text(index)
		if ItemDatabase.items.has(item_name) and ItemDatabase.items[item_name].has("sprite"):
			magicrect.texture = ItemDatabase.items[item_name]["sprite"]
			ActiveAbilityText.text = ItemDatabase.items[item_name]["Active"]
			PassiveAbilityText.text = ItemDatabase.items[item_name]["Passive"]
			current_index = index
			Globals.set_current_magic_index(current_index)
			Globals.set_current_magic_item(ItemDatabase.items[item_name])
func _on_item_list_item_selected(index: int) -> void:
	var item_name = Itemlist.get_item_text(index)
	if ItemDatabase.items.has(item_name) and ItemDatabase.items[item_name].has("sprite"):
		magicrect.texture = ItemDatabase.items[item_name]["sprite"]
		ActiveAbilityText.text = ItemDatabase.items[item_name]["Active"]
		PassiveAbilityText.text = ItemDatabase.items[item_name]["Passive"]
		current_index = index
		Globals.set_current_magic_index(current_index)
		Globals.set_current_magic_item(ItemDatabase.items[item_name])
