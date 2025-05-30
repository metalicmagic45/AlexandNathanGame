extends Node


const Save_Path = "user://save_"

func save_game(slot : int, data : Dictionary) -> void:
	var file = FileAccess.open(Save_Path + str(slot) + ".save", FileAccess.WRITE)
	file.store_war(data)
	file.close()
func load(slot : int) -> Dictionary:
	var file_path = Save_Path + str(slot) + ".save"
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var data = file.get_var()
		file.close()
		return data
	print("save not found")
	return {}
func delete_save(slot: int) -> void:
	var file_path = Save_Path + str(slot) + ".save"
	if FileAccess.file_exists(file_path):
		DirAccess.remove_absolute(file_path)
