extends Control

@onready var char_sprite : TextureRect = $Panel/Control/CenterContainer/CharacterSprite
@onready var char_name : Label = $Panel/Control/NameTag
@onready var stat_box = $Panel/Control/CenterStatContainer/StatBox
@onready var skill_container = $Panel/Control/CenterSkillContainer/SkillContainer

#Updates character sheet according to the currently selected character
var character_name = Playerdata.CurrentCharacter

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ToggleChar"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")
func set_portrait(character_name: String):
	var player = Playerdata.players.get(character_name)
	if player:
		print("Player found")
		var texture = player["sprite"]
		char_sprite.texture = texture
	else:
		print("No player found")
func set_charname(character_name):
	var player = Playerdata.players.get(character_name)
	var name = player["name"]
	char_name.text = name
func set_character(character_name: String) -> void:
	var character_data = Playerdata.players[character_name]
	for child in stat_box.get_children():
		child.queue_free()
	for child in skill_container.get_children():
		child.queue_free()
	# === Populate Basic Stats ===
	for key in ["HP", "MP", "STR", "CON", "DEX", "POW", "INT", "LUCK"]:
		var label = Label.new()
		label.text = "%s: %s" % [key, character_data[key]]
		stat_box.add_child(label)
	# === Populate Skills ===
	for skill in character_data["skills"].keys():
		var label = Label.new()
		label.text = "%s: %d" % [skill, character_data["skills"][skill]]
		skill_container.add_child(label)	
func _ready():
	set_portrait(character_name)
	set_charname(character_name)
	set_character(character_name)
