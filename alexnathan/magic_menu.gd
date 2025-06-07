extends Control

@onready var magicrect = $Panel/ContainerBase/ItemControl/VBoxContainer/ItemDisplayControl/CenterContainer/Panel/CenterContainer/MagicItemDisplay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func set_image(image):
	magicrect.image = image
