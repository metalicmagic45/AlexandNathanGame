extends Node2D
@onready var Kate = get_node("MasterScene/CharacterPortraitTextLayer/TextBoxKateCharacterPortrait")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Character sprite nodes
	if Kate == null:
		print("Kate not found!")
	else: 
		print("Kate Found")
	#var Tyler = get_node("CharacterPortraitTextLayer/TextBoxTylerCharacterPortrait")
	#var Anna = get_node("CharacterPortraitTextLayer/TextBoxAnnaCharacterPortrait")
	#var Jhonson = get_node("CharacterPortraitTextLayer/TextBoxJhonsonCharacterPortrait")
	#var KateUi = get_node("BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/KateCharacterPortrait")
	#var TylerUi = get_node("BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/TylerCharacterPortrait")
	#var AnnaUi = get_node("BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/AnnaCharacterPortrait")
	#var JhonsonUi = get_node("BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/JhonsonCharacterPortrait")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Kate.visible = true 
	print("hi")
