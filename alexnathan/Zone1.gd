extends Node2D

#Varriables to edit Character portraits
@onready var Kate = get_node("MasterScene/CharacterPortraitTextLayer/TextBoxKateCharacterPortrait")
@onready var Tyler = get_node("MasterScene/CharacterPortraitTextLayer/TextBoxTylerCharacterPortrait")
@onready var Anna = get_node("MasterScene/CharacterPortraitTextLayer/TextBoxAnnaCharacterPortrait")
@onready var Jhonson = get_node("MasterScene/CharacterPortraitTextLayer/TextBoxJhonsonCharacterPortrait")
@onready var KateUi = get_node("MasterScene/BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/KateCharacterPortrait")
@onready var TylerUi = get_node("MasterScene/BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/TylerCharacterPortrait")
@onready var AnnaUi = get_node("MasterScene/BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/AnnaCharacterPortrait")
@onready var JhonsonUi = get_node("MasterScene/BottomUiLayer/BottomUi/CharacterPortraitBottomUiLayerLayer/JhonsonCharacterPortrait")

#Varriables to edit Backgrounds
@onready var CarBackground = get_node("MasterScene/ZoneBackgroundLayer/Zone1CarBackground")

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#Character sprite nodes
	#if Kate == null:
		#print("Kate not found!")
	#else: 
		#print("Kate Found")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Kate.visible = true 
<<<<<<< HEAD
	TylerUi.visible = true
	CarBackground.visible = true
=======
>>>>>>> 47466b3d70b822d435c7c056a86858d8d44e1741
