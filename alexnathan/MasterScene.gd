extends Node2D

@onready var PauseLayer = $PauseLayer
@onready var PausePanel = $PauseLayer/Panel
@onready var Portrait: TextureRect = $BottomUiLayer/MainUI/ActionUI/VBoxContainer/background/Panel/CharacterSprite
@onready var HPLabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/Panel/HP
@onready var MPLabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/Panel2/Mana
@onready var start_scene = preload("res://GameArea.tscn")
@onready var Diolouge_Text_Area = get_node("BottomUiLayer/MainUI/ActionUI/VBoxContainer/Panel/DiolougeTextArea")

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
	#Advances Diolouge when space is pressed
	if event.is_action_pressed("DiolougeAdvance"):
		#print(1)
		Diolouge_Text_Outputter()
	
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
		# Displays health and mana for selected character
		var HP = player["HP"]
		var MP = player["MP"]

		HPLabel.bbcode_enabled = true
		MPLabel.bbcode_enabled = true

		HPLabel.bbcode_text = "[center]HP: [color=#FF6666]%s[/color][/center]" % str(HP)
		MPLabel.bbcode_text = "[center]MP: [color=#66CCFF]%s[/color][/center]" % str(MP)


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
#Advances diolouge on button press
func _on_diolouge_advance_button_button_down() -> void:
	Diolouge_Text_Outputter()
	
	
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
	
########################################################################################
################################Diolouge Function#######################################
#An array that contains arrays of text data for each game area
#Text is is Text_Storage.gd
var Area_Diolouge_Holder = TextStorage.Gameplay_Area_Selecter
#Variable to toggle diolouge choice options
var Diolouge_Choice_Toggle = TextStorage.Diolouge_Choice_Toggle
#Variable to store the current index inside an area's diolouge array
var Diolouge_Count = 0
#Current game area corisponding to its "Gameplay_Area_Selecter" index number
var Current_Area = 0
#getting the list of diolouge assinged to the currently selected area
var Currently_Selected_Area = Area_Diolouge_Holder[Current_Area] 

func Diolouge_Text_Outputter():
	#Indexing the current area's list of diolouge to output a string to the text box if the index is a string
	if typeof(Currently_Selected_Area[Diolouge_Count]) == TYPE_STRING and Diolouge_Choice_Toggle == false:
		Diolouge_Text_Area.add_text(Currently_Selected_Area[Diolouge_Count]) #The index repersents the next piece of diolouge to be displayed
		Diolouge_Text_Area.newline()
		Diolouge_Count += 1
	else:
		Diolouge_Choice_Toggle = true
		#Advace Diolouge_Count based on option selected
		Diolouge_Count += 1
		#Diolouge_Choice_Toggle = false
	
	return
	
func Diolouge_Choice_Text_Outputter():
	#Advace Diolouge_Count based on option selected
	#Present 4 choices, each is an array with a string and intiger, Store the int of the selected choice and have it direct you to the proper diolouge response
	return
########################################################################################
