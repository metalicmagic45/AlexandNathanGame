extends Node

var choice_flags = {}
var new_game = false
var Global_Diolouge_Count = 0
#Current game area corisponding to its "Gameplay_Area_Selecter" index number
var Global_Current_Area = 0
var current_magic_index = -1
var current_magic_item = null

var Global_Current_Scene : PackedScene = load("res://CarWilderness.tscn")
#Stores current charcters and allows for any script to reset it
var Global_Current_Characters = []
#Allows for images to be updated using a string to key the correct path
var current_characters_images = {"Jhonson" : preload("res://Pictures/JhonsonPortrait.png"), 
"Kate" : preload("res://Pictures/KatePortrait.png"), 
"Tyler" : preload("res://Pictures/TylerPortrait.png"), 
"Anna" : preload("res://Pictures/AnnaPortrait.png"), 
}
################Dice Rolls###################
func dice_roll() -> int:
	return randi_range(1,20)
func skill_check(DC : int, roll : int, modifier : int) -> bool:
	roll = roll + modifier
	#Auto Complete Check, arbitrary numbers
	if modifier + 10 >= DC + 4:
		print("Auto Pass Happened!")
		return true
	else:
		if roll >= DC:
			return true
		else: 
			return false
#func stat_check(DC : int, roll : int) -> bool:
	
	#var DC2 = DC * 5
	#if roll <= DC2:
		#return true
	#else:
		#return false
#############################################
func get_new_game():
	return new_game
func set_new_game() -> void:
	new_game = false
func get_current_magic_item():
	print(current_magic_item)
	return current_magic_item
	print(current_magic_item)
func set_current_magic_item(item):
	current_magic_item = item
func get_current_magic_index():
	return current_magic_index
func set_current_magic_index(index : int):
	current_magic_index = index
func set_flag(name: String) -> void:
	print("Flag set:", name)
	choice_flags[name] = true

func get_flag(name: String) -> bool:
	var value = choice_flags.get(name, false)
	print("Flag checked:", name, "=", value)
	return value

func clear_flag(name: String) -> void:
	print("Flag cleared:", name)
	choice_flags[name] = false
func set_area_dialogue(count : int, area : int)-> void:
	Global_Diolouge_Count = count
	Global_Current_Area = area
func get_area_global() -> int:
	return Global_Current_Area
func get_diologue_global() -> int:
	return Global_Diolouge_Count
func set_current_global_scene(scene : PackedScene) -> void:
	Global_Current_Scene = scene
func get_current_global_scene() -> PackedScene:
	return Global_Current_Scene
func evaluate_condition_string(expr: String) -> bool:
	if expr.begins_with("!"):
		var flag = expr.substr(1, expr.length())
		return !Globals.get_flag(flag)
	elif expr.begins_with("OR:"):
		var parts = expr.substr(3).split(",", false)
		for p in parts:
			if Globals.get_flag(p.strip_edges()):
				return true
		return false
	elif expr.begins_with("AND:"):
		var parts = expr.substr(4).split(",", false)
		for p in parts:
			if !Globals.get_flag(p.strip_edges()):
				return false
		return true
	else:
		return Globals.get_flag(expr.strip_edges())

	
