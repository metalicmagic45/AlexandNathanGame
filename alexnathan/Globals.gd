extends Node

var choice_flags = {}
var Global_Diolouge_Count = 0
#Current game area corisponding to its "Gameplay_Area_Selecter" index number
var Global_Current_Area = 0

var Global_Current_Scene : PackedScene = load("res://CarWilderness.tscn")

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
	
