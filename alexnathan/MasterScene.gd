extends Node2D

@onready var PauseLayer = $PauseLayer
@onready var PausePanel = $PauseLayer/Panel
@onready var Portrait: TextureRect = $BottomUiLayer/MainUI/ActionUI/VBoxContainer/background/Panel/CharacterSprite
@onready var HPLabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/Panel/HP
@onready var MPLabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/Panel2/Mana
#Loads the first scene
@onready var start_scene = preload("res://CarWilderness.tscn")
@onready var Diolouge_Text_Area = get_node("BottomUiLayer/MainUI/ActionUI/VBoxContainer/Panel/DiolougeTextArea")
@onready var Choice1 = $BottomUiLayer/MainUI/ActionUI/VBoxContainer/DiolougeChoices/VBoxContainer/Button
@onready var Choice2 = $BottomUiLayer/MainUI/ActionUI/VBoxContainer/DiolougeChoices/VBoxContainer/Button2
@onready var Choice3 = $BottomUiLayer/MainUI/ActionUI/VBoxContainer/DiolougeChoices/VBoxContainer/Button3
@onready var HPbar = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/Panel/ProgressBar
@onready var MPbar = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/Buttons/Panel2/TextureProgressBar



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

	# ✅ Prevent advancing if a choice is on screen
	if event.is_action_pressed("DiolougeAdvance") and !Diolouge_Choice_Toggle:
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
		var current_HP = player["Current_HP"]
		var current_MP = player["Current_MP"]
		HPLabel.bbcode_enabled = true
		MPLabel.bbcode_enabled = true

		HPLabel.bbcode_text = "[center]HP: [color=#FF6666]%s[/color][/center]" % str(current_HP)
		MPLabel.bbcode_text = "[center]MP: [color=#66CCFF]%s[/color][/center]" % str(current_MP)
		HPbar.max_value = HP
		HPbar.value = current_HP
		MPbar.max_value = MP
		MPbar.value = current_MP


	else:
		print("No player found")
		
func _ready():
	switch_game_scene(start_scene)
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
	if !Diolouge_Choice_Toggle:
		Diolouge_Text_Outputter()

	
	

########################################################################################
############################Change Scene Function#######################################
func _on_top_button_button_down() -> void:
	#switch_game_scene()
	print(Current_Area)
func _on_right_button_button_down() -> void:
	print(1)
func _on_left_button_button_down() -> void:
	switch_game_scene



func switch_game_scene(scene: PackedScene) -> void:
	var window = $BottomUiLayer/MainUI/VBoxContainer/Window
	var s = scene.instantiate()
	
	for child in window.get_children():
		child.queue_free()
		
	window.add_child(s)	
		
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
	print("DialogueTextOutput called")
	if Diolouge_Count >= Currently_Selected_Area.size():
		return
	
	var current = Currently_Selected_Area[Diolouge_Count]

	# Handle basic string text
	if typeof(current) == TYPE_STRING:
		Diolouge_Text_Area.add_text(current)
		Diolouge_Text_Area.newline()
		Diolouge_Count += 1
		return
	
	# Handle dictionary lines
	if typeof(current) == TYPE_DICTIONARY:
		# Skip line if condition isn't met
		if current.has("condition"):
			var required_flag = current["condition"]
			if !Globals.get_flag(required_flag):
				Diolouge_Count += 1
				Diolouge_Text_Outputter()
				return

		# Set flag if specified
		if current.has("set_flag"):
			var flag = current["set_flag"]
			Globals.set_flag(flag)

		# Handle text lines
		if current["type"] == "text":
			Diolouge_Text_Area.add_text(current["text"])
			Diolouge_Text_Area.newline()

			# Update index, but DO NOT immediately advance again
			if current.has("next_index"):
				Diolouge_Count = current["next_index"]
			else:
				Diolouge_Count += 1
			return

		# Handle choices
		elif current["type"] == "choice":
			show_choices(current["options"])
			Diolouge_Choice_Toggle = true
			return

func show_choices(options: Array):
	Choice1.text = options[0]["text"]
	Choice2.text = options[1]["text"]
	Choice3.text = options[2]["text"]

	# Enable and connect to full options
	Choice1.disabled = false
	Choice2.disabled = false
	Choice3.disabled = false

	Choice1.pressed.connect(func(): handle_choice(options[0]))
	Choice2.pressed.connect(func(): handle_choice(options[1]))
	Choice3.pressed.connect(func(): handle_choice(options[2]))


func handle_choice(option: Dictionary):
	# Disable choices
	Choice1.disabled = true
	Choice2.disabled = true
	Choice3.disabled = true

	# Set flag if present
	if option.has("set_flag"):
		Globals.set_flag(option["set_flag"])
		print("DEBUG: Flag set ->", option["set_flag"])

	# Move to the next dialogue index
	Diolouge_Count = option["next_index"]
	Diolouge_Choice_Toggle = false
	Diolouge_Text_Outputter()


########################################################################################
