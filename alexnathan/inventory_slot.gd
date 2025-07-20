extends Control
@onready var inventorytexture = $CenterContainer/TextureRect
var item_id = null
func set_item(item_key : String, item_data : Dictionary):
	if item_data and item_data.has("sprite"):
		inventorytexture.texture = item_data["sprite"]
		item_id = item_key
	else:
		inventorytexture.texture = null
	
func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		return
	if index == 1:
		var character = Playerdata.CurrentCharacter
		var inventory_reference = Playerinventory.get_inventory(character)
		var item_index = Playerinventory.find_index(item_id, inventory_reference)
		if item_index != -1: # IMPORTANT: Only try to delete if found
			Playerinventory.delete_inventory_item(character, item_index)
			inventorytexture.texture = null
			$OptionButton.select(0)
			$OptionButton.release_focus()
func _ready():
	$OptionButton.select(0)


		
