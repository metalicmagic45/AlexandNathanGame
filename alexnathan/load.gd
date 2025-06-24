extends Control

@onready var PausePanel = $Panel
@onready var title1 = $HBoxContainer/Save1/CenterContainer/VBoxContainer/Title
@onready var title2 = $HBoxContainer/Save2/CenterContainer/VBoxContainer/Title
@onready var title3 = $HBoxContainer/Save3/CenterContainer/VBoxContainer/Title
@onready var title4 = $HBoxContainer/Save4/CenterContainer/VBoxContainer/Title
@onready var title5 = $HBoxContainer/Save5/CenterContainer/VBoxContainer/Title
@onready var save1 = $HBoxContainer/Save1/CenterContainer/VBoxContainer/Save1
@onready var save2 = $HBoxContainer/Save2/CenterContainer/VBoxContainer/Save2
@onready var save3 = $HBoxContainer/Save3/CenterContainer/VBoxContainer/Save3
@onready var save4 = $HBoxContainer/Save4/CenterContainer/VBoxContainer/Save4
@onready var save5 = $HBoxContainer/Save5/CenterContainer/VBoxContainer/Save5
@onready var load1 = $HBoxContainer/Save1/CenterContainer/VBoxContainer/Load1
@onready var load2 = $HBoxContainer/Save2/CenterContainer/VBoxContainer/Load2
@onready var load3 = $HBoxContainer/Save3/CenterContainer/VBoxContainer/Load3
@onready var load4 = $HBoxContainer/Save4/CenterContainer/VBoxContainer/Load4
@onready var load5 = $HBoxContainer/Save5/CenterContainer/VBoxContainer/Load5


func _ready():
	refresh_save_titles()

func _input(event): 
	if event.is_action_pressed("ToggleMasterScene"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")
func refresh_save_titles():
	for i in range(1, 6):
		var path = SaveState.get_save_path(i)
		var label = get_node("HBoxContainer/Save%d/CenterContainer/VBoxContainer/Title" % i)
		if FileAccess.file_exists(path):
			var file = FileAccess.open(path, FileAccess.READ)
			if file:
				var result = JSON.parse_string(file.get_as_text())
				file.close()
				if typeof(result) == TYPE_DICTIONARY and result.has("save_name"):
					label.text = result["save_name"]
				else:
					label.text = "Corrupt"
			else:
				label.text = "Error"
		else:
			label.text = "Empty"

func _on_save_1_button_down() -> void:
	SaveState.save_game(1, title1.text)
	save1.release_focus()


func _on_save_2_button_down() -> void:
	SaveState.save_game(2, title2.text)
	save2.release_focus()

func _on_save_3_button_down() -> void:
	SaveState.save_game(3, title3.text)
	save3.release_focus()

func _on_save_4_button_down() -> void:
	SaveState.save_game(4, title4.text)
	save4.release_focus()

func _on_save_5_button_down() -> void:
	SaveState.save_game(5, title5.text)
	save5.release_focus()

func _on_load_1_button_down() -> void:
	SaveState.load_game(1)
	load1.release_focus()

func _on_load_2_button_down() -> void:
	SaveState.load_game(2)
	load2.release_focus()

func _on_load_3_button_down() -> void:
	SaveState.load_game(3)
	load3.release_focus()

func _on_load_4_button_down() -> void:
	SaveState.load_game(4)
	load4.release_focus()

func _on_load_5_button_down() -> void:
	SaveState.load_game(5)
	load5.release_focus()
	
func _on_exit_to_master_button_down() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
