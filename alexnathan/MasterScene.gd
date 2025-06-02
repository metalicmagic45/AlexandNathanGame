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
@onready var top_button = $BottomUiLayer/Control/TopButton
@onready var bottom_button = $BottomUiLayer/Control/BottomButton
@onready var right_button = $BottomUiLayer/Control/RightButton
@onready var left_button = $BottomUiLayer/Control/LeftButton
@onready var dicelabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/VBoxContainer/Dicelabel



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
		

	if event.is_action_pressed("DiolougeAdvance") and !Diolouge_Choice_Toggle:
		clear_choices()
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
	switch_game_scene(Globals.get_current_global_scene())
	Diolouge_Count = Globals.get_diologue_global()
	Current_Area = Globals.get_area_global()
	set_portrait(character_name)

func _on_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_inventory_pressed() -> void:
	get_tree().change_scene_to_file("res://inventory_ui.tscn")
func _on_party_pressed() -> void:
	get_tree().change_scene_to_file("res://party_ui.tscn")
func _on_character_pressed() -> void:
	get_tree().change_scene_to_file("res://character_ui.tscn")
#Advances diolouge on button press
func _on_diolouge_advance_button_button_down() -> void:
	clear_choices()
	if !Diolouge_Choice_Toggle:
		Diolouge_Text_Outputter()
func reset_dialogue():
	Diolouge_Text_Area.clear()
	Diolouge_Count = 0
	clear_choices()
	
	# Check if the first entry is a choice and set toggle accordingly
	var current = Currently_Selected_Area[Diolouge_Count]
	if typeof(current) == TYPE_DICTIONARY and current.get("type", "") == "choice":
		Diolouge_Choice_Toggle = true
	else:
		Diolouge_Choice_Toggle = false

########################################################################################
################################Diolouge Function#######################################
#An array that contains arrays of text data for each game area
#Text is is Text_Storage.gd
var Area_Diolouge_Holder = TextStorage.Gameplay_Area_Selecter
#Variable to toggle diolouge choice options
var Diolouge_Choice_Toggle = TextStorage.Diolouge_Choice_Toggle
#Variable to store the current index inside an area's diolouge array
var Diolouge_Count = Globals.get_diologue_global()
#Current game area corisponding to its "Gameplay_Area_Selecter" index number
var Current_Area = Globals.get_area_global()
#getting the list of diolouge assinged to the currently selected area
var Currently_Selected_Area = Area_Diolouge_Holder[Current_Area] 
func set_current_area():
	Current_Area = current_scene_instance.get_ID()
	Currently_Selected_Area = Area_Diolouge_Holder[Current_Area]

var test = 0
func Diolouge_Text_Outputter():
	print(test, "#######################################")
	test += 1
	print("DialogueTextOutput called")
	print(Diolouge_Count)
	
	if Diolouge_Count >= Currently_Selected_Area.size():
		return
	
	var current = Currently_Selected_Area[Diolouge_Count]

	# Handle basic string text
	if typeof(current) == TYPE_STRING:
		if Diolouge_Choice_Toggle:
			return
		Diolouge_Text_Area.add_text(current)
		Diolouge_Text_Area.newline()
		Diolouge_Count += 1
		return
	
	# Handle dictionary lines
	if typeof(current) == TYPE_DICTIONARY:
		# Skip line if condition isn't met
		if current.has("condition"):
			var required_flag = current["condition"]
			print("Condition found")
			if !Globals.get_flag(required_flag):
				Diolouge_Count += 1
				Diolouge_Text_Outputter()
				return			
		# Handle type: "jump" entries
		if current["type"] == "jump":
			# Set flag if specified
			if current.has("set_flag"):
				var flag = current["set_flag"]
				Globals.set_flag(flag)
			var conditions = current.get("conditions", [])
			var all_met := true
			for cond in conditions:
				if !Globals.evaluate_condition_string(cond):
					all_met = false
					break

			if all_met:
				var target_flag = current.get("jump", "")
				var jump_index = flag_jump(Currently_Selected_Area, target_flag)
				if jump_index != -1:
					print("Jumping to:", target_flag)
					Diolouge_Count = jump_index
					Diolouge_Text_Outputter()
					return
				else:
					print("Jump failed: Flag not found ->", target_flag)

			# If jump not taken or failed, advance to next dialogue
			Diolouge_Count += 1
			Diolouge_Text_Outputter()
			return

		# Set flag if specified
		if current.has("set_flag"):
			var flag = current["set_flag"]
			Globals.set_flag(flag)

		# Handle text lines
		if current["type"] == "text":
			if current.has("condition"):
				var condition_expr = current["condition"]
				if !Globals.evaluate_condition_string(condition_expr):
					Diolouge_Count += 1
					Diolouge_Text_Outputter()
					return
			if current.has("set_flag"):
				var flag = current["set_flag"]
				Globals.set_flag(flag)
				print("DEBUG: Set flag from text entry:", flag)

			Diolouge_Text_Area.add_text(current["text"])
			Diolouge_Text_Area.newline()

			if current.has("jump"):
				var target_flag = current["jump"]
				var jump_index = flag_jump(Currently_Selected_Area, target_flag)		
				if jump_index != -1:
					Diolouge_Count = jump_index
					print("yaya")
			else:
				Diolouge_Count += 1


		# Handle choices
		elif current["type"] == "choice":
			show_choices(current["options"])
			Diolouge_Choice_Toggle = true
			return
		if current["type"] == "skillcheck":
			dicelabel.text = ""
			var char_name = Playerdata.CurrentCharacter
			var skill_name = current.get("skill", "")
			var roll = Skillcheck.dice_roll()
			var dc = Playerdata.get_skill(char_name, skill_name)
			var flag = Skillcheck.skill_check(dc, roll)
			var check_pass = current.get("check_pass", "")
			var check_fail = current.get("check_fail", "")
			if flag == true:
				Globals.set_flag(check_pass)
				print("check pass")
			else:
				Globals.set_flag(check_fail)
				print("check fail")
			dicelabel.text = str(roll)
			if current.has("jump"):
				var target_flag = current["jump"]
				var jump_index = flag_jump(Currently_Selected_Area, target_flag)	
				print(jump_index)	
				if jump_index != -1:
					Diolouge_Count = jump_index
			else:
				Diolouge_Count += 1
			Diolouge_Text_Outputter()
			return
		if current["type"] == "statcheck":
			dicelabel.text = ""
			var char_name = Playerdata.CurrentCharacter
			var stat_name = current.get("stat", "")
			var roll = Skillcheck.dice_roll()
			var dc = Playerdata.get_stat(char_name, stat_name)
			var flag = Skillcheck.stat_check(dc, roll)
			var check_pass = current.get("check_pass", "")
			var check_fail = current.get("check_fail", "")
			if flag == true:
				Globals.set_flag(check_pass)
				print("check pass")
			else:
				Globals.set_flag(check_fail)
				print("check fail")
			dicelabel.text = str(roll)	
			if current.has("jump"):
				var target_flag = current["jump"]
				var jump_index = flag_jump(Currently_Selected_Area, target_flag)	
				print(jump_index)	
				if jump_index != -1:
					Diolouge_Count = jump_index
			else:
				Diolouge_Count += 1
			Diolouge_Text_Outputter()
			return
func flag_jump(dialogue_array: Array, target_flag: String) -> int:
	for i in range(dialogue_array.size()):
		var entry = dialogue_array[i]
		if typeof(entry) == TYPE_DICTIONARY and entry.has("flag") and entry["flag"] == target_flag:
			return i
			print("yay")
	return -1

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
	if option.has("set_flag"):
		Globals.set_flag(option["set_flag"])
		print("DEBUG: Flag set ->", option["set_flag"])

	if option.has("jump"):
		var target_flag = option["jump"]
		var jump_index = flag_jump(Currently_Selected_Area, target_flag)
		if jump_index != -1:
			Diolouge_Count = jump_index
		else:
			Diolouge_Count += 1
	else:
		Diolouge_Count += 1
	Diolouge_Choice_Toggle = false
func clear_choices():
	for button in [Choice1, Choice2, Choice3]:
		button.text = ""
		button.release_focus()  # Deselects the button if it had focus
func hide_buttons() -> void:
	if current_scene_instance == null:
		return                     # nothing loaded yet
	# show or hide each nav button depending on whether a destination exists
	if current_scene_instance.has_method("get_top") and current_scene_instance.get_top() != null:
		top_button.visible = true
	else:
		top_button.visible = false

	if current_scene_instance.has_method("get_bottom") and current_scene_instance.get_bottom() != null:
		bottom_button.visible = true
	else:
		bottom_button.visible = false

	if current_scene_instance.has_method("get_right") and current_scene_instance.get_right() != null:
		right_button.visible = true
	else:
		right_button.visible = false

	if current_scene_instance.has_method("get_left") and current_scene_instance.get_left() != null:
		left_button.visible = true
	else:
		left_button.visible = false
########################################################################################

########################################################################################
############################Change Scene Function#######################################
func _process(delta: float) -> void:
	hide_buttons()
	Globals.set_current_global_scene(current_scene_packed_scene)
	Globals.set_area_dialogue(Diolouge_Count, Current_Area)

var current_scene_instance: Node = null
var current_scene_packed_scene: PackedScene = null

func switch_game_scene(scene: PackedScene) -> void:
	var window = $BottomUiLayer/MainUI/VBoxContainer/Window
	var s = scene.instantiate()

	for child in window.get_children():
		child.queue_free()

	current_scene_instance = s
	current_scene_packed_scene = scene  # ✅ store PackedScene
	window.add_child(s)

	set_current_area()
	reset_dialogue()

func _on_bottom_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_bottom"):
		switch_game_scene(current_scene_instance.get_bottom())

func _on_top_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_top"):
		switch_game_scene(current_scene_instance.get_top())

func _on_right_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_right"):
		switch_game_scene(current_scene_instance.get_right())

func _on_left_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_left"):
		switch_game_scene(current_scene_instance.get_left())
func _on_load_button_down() -> void:
	get_tree().change_scene_to_file("res://load.tscn")
