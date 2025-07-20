extends Node2D

#Pause menu nodes
#Must preload the scene with the UI element, instaniate it (witch creates a malluable copy), then add it as a child
@onready var PauseLayer = $PauseLayer
@onready var PausePanel = $PauseLayer/Panel
@onready var PauseLayerBackground = get_node("PauseLayer/PauseLayerBackground")
@onready var Menu_Actions = get_node("PauseLayer/Panel/HBoxContainer/Control2/CenterContainer/Control")
@onready var Settings_Button = get_node("PauseLayer/Panel/Control/VBoxContainer/Settings")
#@onready var Settings = preload("res://Settings.tscn")

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
@onready var top_button = $BottomUiLayer/MainUI/VBoxContainer/Control/TopButton
@onready var bottom_button = $BottomUiLayer/MainUI/VBoxContainer/Control/BottomButton
@onready var right_button = $BottomUiLayer/MainUI/VBoxContainer/Control/RightButton
@onready var left_button = $BottomUiLayer/MainUI/VBoxContainer/Control/LeftButton
@onready var dicelabel = $BottomUiLayer/MainUI/VBoxContainer/BottomUI/HBoxContainer/VBoxContainer/Dicelabel
@onready var Character1Texture = $BottomUiLayer/Control/HBoxContainer/Control2/CenterContainer/HBoxContainer/CenterContainer/LeftTexture
@onready var Character2Texture = $BottomUiLayer/Control/HBoxContainer/Control2/CenterContainer/HBoxContainer/CenterContainer2/RightTexture
@onready var PopUpImage = $BottomUiLayer/PopUp/CenterContainer/TextureRect
@onready var PopUp = $BottomUiLayer/PopUp
@onready var notes = $BottomUiLayer/Notes
@onready var PopUpMsg = $BottomUiLayer/Panel/PopUpMessage
@onready var PopUpPannel = $BottomUiLayer/Panel

var area_context_stack: Array = []
var npc_interaction : bool = false


#Stores currently selected character for set_portrait(), ran in _ready()
var character_name = Playerdata.CurrentCharacter
var popup = false

func display_mission():
	var not_new_game = Globals.get_flag("NewGameFalse")
	var image = preload("res://Pictures/Missionreport.png")
	if not_new_game == false:
		PopUp.visible = !PopUp.visible
		PopUpImage.texture = image
		popup = true

func remove_image(Placement : String):
	if Placement == "left":
		Character1Texture.texture = null
		return
	if Placement == "right":
		Character2Texture.texture = null
		return

func depict_image(character : String, Placement : String, type : String):
	var image = null
	if type == "PlayerCharacter":		
		image = Playerdata.players[character].get("sprite", null)
		if Placement == "left":
			Character1Texture.texture = image
		if Placement == "right":
			Character2Texture.texture = image	
	elif type == "NPC":
		if Npcs.NPCs.has(character):
			image = Npcs.NPCs[character].get("sprite", null)
		else:
			print("NPC not found:", character)
			return
		if Placement == "left":
			Character1Texture.texture = image
		if Placement == "right":
			Character2Texture.texture = image		
func _input(event): 
	if event.is_action_pressed("uicancel"):
		if popup:
			PopUp.visible = false
			PopUpImage.texture = null
			popup = false
			Globals.set_flag("NewGameFalse")
		elif npc_interaction:
			return  # Don't do anything during NPC interaction
		else:
			toggle_pause_menu()
	if event.is_action_pressed("ToggleMasterScene"):
		if popup == true:
			return
		else:
			get_tree().change_scene_to_file("res://act_1_map.tscn")

	if event.is_action_pressed("ToggleInvetory"):
		if popup == true:
			return
		else:
			get_tree().change_scene_to_file("res://inventory_ui.tscn")
	if event.is_action_pressed("ToggleParty"):
		if popup == true:
			return
		else:	
			get_tree().change_scene_to_file("res://party_ui.tscn")
	if event.is_action_pressed("ToggleChar"):
		if popup == true:
			return
		else:
			get_tree().change_scene_to_file("res://character_ui.tscn")
	if event.is_action_pressed("ToggleMagic") and !Input.is_key_pressed(KEY_CTRL):
		if popup == true:
			return
		else:
			get_tree().change_scene_to_file("res://magic_menu.tscn")
	if event.is_action_pressed("DiolougeAdvance") and !Diolouge_Choice_Toggle:
		if popup == true:
			return
		else:
			clear_choices()
			Diolouge_Text_Outputter()
	if event.is_action_pressed("NotesToggle"):
		if popup == true:
			return
		else:
			get_tree().change_scene_to_file("res://notes.tscn")
		

	
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
	Journal.connect("journal_entry_added", Callable(self, "_on_journal_entry_added"))
	hide_buttons()
	display_mission()
func _on_journal_entry_added() -> void:
	show_journal_popup("New Journal Entry Added")

	
#########################################################################
#########################Pause Menu#####################################
var pause_layer_elements = 1

func toggle_pause_menu():
	PauseLayer.visible = !PauseLayer.visible
	PauseLayerBackground.visible = !PauseLayerBackground.visible

func _on_save_button_down() -> void:
	pass # Replace with function body.	
	
func _on_load_button_down() -> void:
	get_tree().change_scene_to_file("res://load.tscn")	
	
func _on_menu_button_down() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_settings_button_down() -> void:
	get_tree().change_scene_to_file("res://Settings.tscn")
		
#########################################################################

func _on_inventory_pressed() -> void:
	if popup == true:
		return
	else:
		get_tree().change_scene_to_file("res://inventory_ui.tscn")
func _on_party_pressed() -> void:
	if popup == true:
		return
	else:
		get_tree().change_scene_to_file("res://party_ui.tscn")
func _on_character_pressed() -> void:
	if popup == true:
		return
	else:
		get_tree().change_scene_to_file("res://character_ui.tscn")
#Advances diolouge on button press
func _on_diolouge_advance_button_button_down() -> void:
	if popup == true:
		return
	else:
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
func push_area_context():
	area_context_stack.push_back({"area": Currently_Selected_Area, "index": Diolouge_Count + 1 })

func pop_area_context():
	if area_context_stack.size() > 0:
		var ctx = area_context_stack.pop_back()
		Currently_Selected_Area = ctx["area"]
		Diolouge_Count = ctx["index"]


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
		if current["type"] == "RemoveDisplay":
			var direction = current["direction"]
			remove_image(direction)
			Diolouge_Count += 1
			Diolouge_Text_Outputter()
		if current["type"] == "Display":
			var chartype = current["chartype"]
			var character = current["character"]
			var direction = current["direction"]
			depict_image(character, direction, chartype)
			Diolouge_Count += 1
			Diolouge_Text_Outputter()
		# Handle NPC dialogues
		if current["type"] == "NPC":
			var npc_name = current.get("character", "")
			if Npcs.NPCs.has(npc_name):
				# Save current context
				push_area_context()
				# Switch to NPC dialogue
				Currently_Selected_Area = Npcs.NPCs[npc_name].char_dialogue
				Diolouge_Count = 0
				npc_interaction = true
				Diolouge_Text_Outputter()
				return
			else:
				print("NPC not found:", npc_name)
				Diolouge_Count += 1
				Diolouge_Text_Outputter()
				return
				
		#Load and remove characters
		#Toggle opacity for currently talking charaacters
		#May be in multiple places, in handle_choices() and here
		#if current.has("talking"):
			#Character1Texture.visible = false
			#Character2Texture.visible = false

			#print("Talking has been called, ", option.get("talking", ""))
			#Based on who is talking, there current image will be toggled on
			#current_characters_texture[current.get("talking")].visible = true

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
			if current.has("add_journal"):
				var journal_data = current["add_journal"]
				Journal.add_journal_entry(
					journal_data["id"],
					journal_data["title"],
					journal_data["description"],
					journal_data["status"]
				)

			if current.has("jump"):
				var target_flag = current["jump"]
				var jump_index = flag_jump(Currently_Selected_Area, target_flag)		
				if jump_index != -1:
					Diolouge_Count = jump_index
					print("yaya")
			else:
				Diolouge_Count += 1
		if current["type"] == "STOP":
			if area_context_stack.size() > 0:
				print("Returning from NPC dialogue.")
				npc_interaction = false
				pop_area_context()
				Diolouge_Text_Outputter()
			else:
				print("End of main dialogue.")
			return

		# Handle choices
		elif current["type"] == "choice":
			show_choices(current["options"])
			Diolouge_Choice_Toggle = true
			return
		if current["type"] == "skillcheck":
			dicelabel.text = ""
			var char_name = Playerdata.CurrentCharacter
			var roll = Globals.dice_roll()
			#Gets the skill being rolled for
			var skill_name = current.get("skill", "")
			#Gets the DC for the check
			var dc = current.get("DC", "")
			#Gets current characters modifer for roll
			var modifier = Playerdata.get_skill(char_name, skill_name)
			print("Skill Modifier, ", modifier)
			print("Skill DC, ", dc)
			print("Skill Roll, ", roll)
			print("Total Roll, ", roll + modifier)
			var flag = Globals.skill_check(dc, roll, modifier)
			var check_pass = current.get("check_pass", "")
			var check_fail = current.get("check_fail", "")
			if flag == true:
				Globals.set_flag(check_pass)
				print("check pass")
			else:
				Globals.set_flag(check_fail)
				print("check fail")
			dicelabel.text = str(roll + modifier)
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
		#if current["type"] == "statcheck":
			#dicelabel.text = ""
			#var char_name = Playerdata.CurrentCharacter
			#var stat_name = current.get("stat", "")
			#var roll = Globals.dice_roll()
			#var dc = Playerdata.get_stat(char_name, stat_name)
			#var flag = Globals.stat_check(dc, roll)
			#var check_pass = current.get("check_pass", "")
			#var check_fail = current.get("check_fail", "")
			#if flag == true:
				#Globals.set_flag(check_pass)
				#print("check pass")
			#else:
				#Globals.set_flag(check_fail)
				#print("check fail")
			#dicelabel.text = str(roll)	
			#if current.has("jump"):
				#var target_flag = current["jump"]
				#var jump_index = flag_jump(Currently_Selected_Area, target_flag)	
				#print(jump_index)	
				#if jump_index != -1:
					#Diolouge_Count = jump_index
			#else:
				#Diolouge_Count += 1
			#Diolouge_Text_Outputter()
			#return
func flag_jump(dialogue_array: Array, target_flag: String) -> int:
	for i in range(dialogue_array.size()):
		var entry = dialogue_array[i]
		if typeof(entry) == TYPE_DICTIONARY and entry.has("flag") and entry["flag"] == target_flag:
			return i
	return -1

var current_dictonary = Currently_Selected_Area[Diolouge_Count]
func Choice1_Handler():
	#var options = current_dictonary["options"]
	handle_choice(current_dictonary["options"][0])
	#print("This is the current dictonary", current_dictonary)
func Choice2_Handler():
	#var options = current_dictonary["options"]
	handle_choice(current_dictonary["options"][1])
func Choice3_Handler():
	#var options = current_dictonary["options"]
	handle_choice(current_dictonary["options"][2])

func show_choices(options: Array):
	
	clear_choices()  # Optional: clear buttons first
	current_dictonary = Currently_Selected_Area[Diolouge_Count]

	# Enable and connect to full options
	Choice1.disabled = false
	Choice2.disabled = false
	Choice3.disabled = false
	
	if Choice1.pressed.is_connected(Callable(self, "Choice1_Handler")):
		#print("connection detected")
		Choice1.pressed.disconnect(Callable(self, "Choice1_Handler"))
		Choice2.pressed.disconnect(Callable(self, "Choice2_Handler"))
		Choice3.pressed.disconnect(Callable(self, "Choice3_Handler"))
			
	
	# Option 1
	if options.size() > 0:
		Choice1.text = options[0]["text"]
		Choice1.disabled = false
		Choice1.visible = true
		Choice1.pressed.connect(Callable(self, "Choice1_Handler"))

	# Option 2
	if options.size() > 1:
		Choice2.text = options[1]["text"]
		Choice2.disabled = false
		Choice2.visible = true
		Choice2.pressed.connect(Callable(self, "Choice2_Handler"))

	# Option 3
	if options.size() > 2:
		Choice3.text = options[2]["text"]
		Choice3.disabled = false
		Choice3.visible = true
		Choice3.pressed.connect(Callable(self, "Choice3_Handler"))


func handle_choice(option: Dictionary):
	if option.has("set_flag"):
		Globals.set_flag(option["set_flag"])
		print("DEBUG: Flag set ->", option["set_flag"])
	#var turn = 0
	#Toggles visability based on who is talking
	#if option.has("talking"):
			#Character1Texture.visible = false
			#Character2Texture.visible = false
			#print("Talking has been called, ", option.get("talking", ""))
			#Based on who is talking, there current image will be toggled on
 			#current_characters_texture[option.get("talking")].visible = true
			

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
func disable_visible_navigation_buttons() -> void:
	if top_button.visible:
		top_button.disabled = true
	if bottom_button.visible:
		bottom_button.disabled = true
	if left_button.visible:
		left_button.disabled = true
	if right_button.visible:
		right_button.disabled = true
func enable_visible_navigation_buttons() -> void:
	if top_button.visible:
		top_button.disabled = false
	if bottom_button.visible:
		bottom_button.disabled = false
	if left_button.visible:
		left_button.disabled = false
	if right_button.visible:
		right_button.disabled = false
	
########################################################################################
################################Character Rendering#####################################
var current_characters = []#cureent scenes starting characters
#Global dictonary that stores all the images in, res://CarWilderness.tscn::GDScript_j4bmp
var current_characters_images = Globals.current_characters_images
#Dict that stores the characters fromcurrent characters as the keys for their corosponding CharacterTexture
var current_characters_texture = {}


########################################################################################
############################Change Scene Function#######################################
func _process(delta: float) -> void:
	hide_buttons()
	if popup or npc_interaction == true:
		disable_visible_navigation_buttons()
	else:
		enable_visible_navigation_buttons()
	Globals.set_current_global_scene(current_scene_packed_scene)
	Globals.set_area_dialogue(Diolouge_Count, Current_Area)

var current_scene_instance: Node = null
var current_scene_packed_scene: PackedScene = null

func switch_game_scene(scene: PackedScene) -> void:
	
	var window = $BottomUiLayer/MainUI/VBoxContainer/Control/Window
	for child in window.get_children():
		child.queue_free()
	var s = scene.instantiate()


	current_scene_instance = s
	current_scene_packed_scene = scene  
	window.add_child(s)
	
	set_current_area()
	reset_dialogue()

func _on_bottom_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_bottom"):
		switch_game_scene(current_scene_instance.get_bottom())



func _on_right_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_right"):
		switch_game_scene(current_scene_instance.get_right())

func _on_left_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_left"):
		switch_game_scene(current_scene_instance.get_left())

func _on_magic_button_down() -> void:
	if popup == true:
		return
	else:
		get_tree().change_scene_to_file("res://magic_menu.tscn")
func _on_top_button_button_down() -> void:
	if current_scene_instance and current_scene_instance.has_method("get_top"):
		switch_game_scene(current_scene_instance.get_top())
func show_journal_popup(message: String) -> void:
	print("PopUp Function Called")
	PopUpPannel.visible = !PopUpPannel.visible
	PopUpMsg.text = message
	await get_tree().create_timer(1.0).timeout  # Wait 1.0 seconds
	PopUpPannel.visible = false
