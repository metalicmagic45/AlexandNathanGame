extends Control
@onready var partyslotscene = preload("res://party_member_slot.tscn")
@onready var party_container = $GridContainer

var party = {}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ToggleParty"):
		get_tree().change_scene_to_file("res://MasterScene.tscn")

func add_party_member(character_name: String) -> void:
	var character = Playerdata.players.get(character_name)
	if character and not party.has(character_name):
		party[character_name] = character
func remove_party_member(character_name: String) -> void:
	if party.has(character_name):
		party.erase(character_name)
func _ready() -> void:
	add_party_member("Johnson")
	add_party_member("Kate")
	add_party_member("Anna")
	add_party_member("Tyler")
	initialize_party_slots()
func initialize_party_slots() -> void:
	# Clear existing slots first
	for child in party_container.get_children():
		child.queue_free()
	# Create a slot for each member
	for character_name in party.keys():
		var slot = partyslotscene.instantiate()
		party_container.add_child(slot)
		slot.set_member_data(character_name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
