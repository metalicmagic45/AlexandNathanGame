extends Node

var choice_flags = {}

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
