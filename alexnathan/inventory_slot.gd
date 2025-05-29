extends Control
@onready var sprite_2d: Sprite2D = $CenterContainer/Control/Sprite2D
var item_id = null
func set_item(item_key : String, item_data : Dictionary):
	if item_data and item_data.has("sprite"):
		sprite_2d.texture = item_data["sprite"]
		item_id = item_key
	else:
		sprite_2d.texture = null
	
func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		return
	if index == 1:
		var character = Playerdata.CurrentCharacter
		var inventory_reference = Playerinventory.get_inventory(character)
		var item_index = Playerinventory.find_index(item_id, inventory_reference)
		if item_index != -1: # IMPORTANT: Only try to delete if found
			Playerinventory.delete_inventory_item(character, item_index)
			sprite_2d.texture = null
			$OptionButton.select(0)
			$OptionButton.release_focus()
func _ready():
	$OptionButton.select(0)


		
