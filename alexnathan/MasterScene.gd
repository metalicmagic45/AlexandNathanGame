extends Node2D

@onready var PauseLayer = $PauseLayer
@onready var PausePanel = $PauseLayer/Panel
@onready var Kate = get_node("CharacterPortraitTextLayer/TextBoxKateCharacterPortrait")
@onready var Portrait: TextureRect = $BottomUiLayer/MainUI/ActionUI/VBoxContainer/background/Panel/CharacterSprite
@onready var HPLabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/HP
@onready var MPLabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/Mana
@onready var start_scene = preload("res://GameArea.tscn")

#Stores currently selected character for set_portrait(), ran in _ready()
var character_name = Playerdata.CurrentCharacter

func _input(event): 
	if event.is_action_pressed("uicancel"):
		toggle_pause_menu()
	if event.is_action_pressed("ToggleInvetory"):
		get_tree().change_scene_to_file("res://inventory_ui.tscn")
	if event.is_action_pressed("ToggleParty"):
		get_tree().change_scene_to_file("res://party_ui.tscn")
	if event.is_action_pressed("ToggleChar"):
		get_tree().change_scene_to_file("res://character_ui.tscn")
func toggle_pause_menu():
	PausePanel.visible = !PausePanel.visible
func reset_portrait():
	for child in Portrait.get_children():
		child.queue_free()
func set_portrait(character_name: String):
	var player = Playerdata.players.get(character_name)
	if player:
		print("Player found")
		var texture = player["sprite"]
		Portrait.texture = texture
		#Displays health and mana for selected character
		var HP = player["HP"]
		var MP = player["MP"]
		HPLabel.text = "HP: %s" % str(HP)
		MPLabel.text = "MP: %s" % str(MP)
	else:
		print("No player found")
		
func _ready():
	add_game_scene(start_scene)
	set_portrait(character_name)
func _on_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
# Replace with function body.
#func _process(delta: float) -> void:
	#Kate.visible = true
func _on_inventory_pressed() -> void:
	get_tree().change_scene_to_file("res://inventory_ui.tscn")
func _on_party_pressed() -> void:
	get_tree().change_scene_to_file("res://party_ui.tscn")
func _on_character_pressed() -> void:
	get_tree().change_scene_to_file("res://character_ui.tscn")
	
	
func add_game_scene(scene):
	var window = $BottomUiLayer/MainUI/VBoxContainer/Window
	var s = scene.instantiate()
	window.add_child(s)
	s.connect("change_scene", Callable(self, "switch_game_scene"))
	pass
	
func switch_game_scene(scene: PackedScene) -> void:
	var window = $BottomUiLayer/MainUI/VBoxContainer/Window

	for child in window.get_children():
		child.queue_free()
		
	add_game_scene(scene)
