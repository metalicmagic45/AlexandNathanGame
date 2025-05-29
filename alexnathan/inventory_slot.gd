extends Control
@onready var sprite_2d: Sprite2D = $CenterContainer/Control/Sprite2D
var item_id = null
func set_item(item_data):
	if item_data and item_data.has("sprite"):
		sprite_2d.texture = item_data["sprite"]
		item_id = item_data["name"]
	else:
		sprite_2d.texture = null
	
func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		return
	if index == 1:
		var character = Playerdata.CurrentCharacter
		var data = Playerinventory.get_inventory(character)
		var item_index = Playerinventory.find_index(character, data)
		Playerinventory.delete_inventory_item(character, item_index)
		sprite_2d.texture = null
		$OptionButton.select(0)         # Reset to "Menu"
		$OptionButton.release_focus()   # Remove highlight/focus outline

func _ready():
	$OptionButton.select(0)


		
