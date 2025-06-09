extends Node

const SAVE_PREFIX := "user://savegame_slot_"
const SAVE_SUFFIX := ".save"

func get_save_path(slot: int) -> String:
	return "%s%d%s" % [SAVE_PREFIX, slot, SAVE_SUFFIX]
	
func save_game(slot: int, save_name : String) -> void:
	var save_data = {
		"inventory": Playerinventory.player_inventories, # Replace this with your own inventory logic
		"flags": Globals.choice_flags,                 # Replace with your own global flags
		"dialogue_count": Globals.Global_Diolouge_Count,
		"current_area": Globals.Global_Current_Area,
		"current_scene": Globals.Global_Current_Scene.resource_path,
		"current_magic_item": Globals.current_magic_index,
		"save_name": save_name,
	}
	var path = get_save_path(slot)
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("Saved to slot", slot)
	else:
		print("Failed to open file for saving.")
func load_game(slot: int) -> void:
	var path = get_save_path(slot)
	
	if not FileAccess.file_exists(path):
		print("No save found in slot", slot)
		return
	
	var file = FileAccess.open(path, FileAccess.READ)
	if not file:
		print("Failed to open save file for reading.")
		return
	
	var save_text = file.get_as_text()
	file.close()
	
	var result = JSON.parse_string(save_text)
	
	if typeof(result) != TYPE_DICTIONARY:
		print("Save file is corrupted or invalid.")
		return
	
	# Now restore the state
	Playerinventory.player_inventories = result["inventory"]
	Globals.choice_flags = result["flags"]
	Globals.Global_Diolouge_Count = result["dialogue_count"]
	Globals.Global_Current_Area = result["current_area"]
	Globals.Global_Current_Scene = load(result["current_scene"])
	Globals.set_current_magic_index(result["current_magic_item"])
	
	print("Loaded game from slot", slot)

	
