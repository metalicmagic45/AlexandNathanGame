extends Node2D

@onready var PauseLayer = $PauseLayer
@onready var PausePanel = $PauseLayer/Panel
@onready var Kate = get_node("CharacterPortraitTextLayer/TextBoxKateCharacterPortrait")
@onready var Portrait: VBoxContainer = $BottomUiLayer/BottomUI/Panel/HBoxContainer/Potrait




func _input(event): 
	if event.is_action_pressed("uicancel"):
		toggle_pause_menu()
	if event.is_action_pressed("ToggleInvetory"):
		get_tree().change_scene_to_file("res://inventory_ui.tscn")
	if event.is_action_pressed("ToggleParty"):
		get_tree().change_scene_to_file("res://party_ui.tscn")
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
		var texture_rect = TextureRect.new()
		texture_rect.texture = texture
		Portrait.add_child(texture_rect)
	else:
		print("No player found")
		
func _ready():
	set_portrait("Johnson")
func _on_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
# Replace with function body.
#func _process(delta: float) -> void:
	#Kate.visible = true
func _on_inventory_pressed() -> void:
	get_tree().change_scene_to_file("res://inventory_ui.tscn")
func _on_party_pressed() -> void:
	get_tree().change_scene_to_file("res://party_ui.tscn")
