extends Node

const SAVE_PREFIX := "user://savegame_slot_"
const SAVE_SUFFIX := ".save"
signal save_popup

func new_game() -> void:
	# Reset inventory
	Playerinventory.player_inventories.clear()
	# Reset flags
	Globals.choice_flags.clear()
	# Reset dialogue count, current area/scene, etc.
	Globals.Global_Diolouge_Count = 0
	Globals.Global_Current_Area = 0
	Globals.Global_Current_Scene = load("res://CarWilderness.tscn")  # Set the default scene
	# Reset magic item
	Globals.current_magic_item = null  # Or default item if you have one
	# Reset journal
	Journal.journal_entries = {
		"MissionReport": {
			"title": "Operation Hollow Butcher",
			"status": "Incomplete",
			"description": """You have been ordered to investigate the disappearance of Regan Hilstad,
	secure occult and supernatural items possessed by the cult, gather intelligence of the cult,
	assess threat level, and report findings for potential escalation."""
		}
	}	
	# Transition to the starting scene
	get_tree().change_scene_to_file("res://MasterScene.tscn")  

func get_save_path(slot: int) -> String:
	return "%s%d%s" % [SAVE_PREFIX, slot, SAVE_SUFFIX]
	
func save_game(slot: int, save_name : String) -> void:
	var save_data = {
		"inventory": Playerinventory.player_inventories, # Replace this with your own inventory logic
		"flags": Globals.choice_flags,                 # Replace with your own global flags
		"dialogue_count": Globals.Global_Diolouge_Count,
		"current_area": Globals.Global_Current_Area,
		"current_scene": Globals.Global_Current_Scene.resource_path,
		"current_magic_item_name": ItemDatabase.items.find_key(Globals.current_magic_item),
		"save_name": save_name,
		"Journal_Entries": Journal.journal_entries
	}
	var path = get_save_path(slot)
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("Saved to slot", slot)
		emit_signal("save_popup")
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
	Journal.journal_entries = result["Journal_Entries"]
	var item_name = result.get("current_magic_item_name", null)
	if item_name != null and ItemDatabase.items.has(item_name):
		Globals.set_current_magic_item(ItemDatabase.items[item_name])
	get_tree().change_scene_to_file("res://MasterScene.tscn")

	
	print("Loaded game from slot", slot)

	
