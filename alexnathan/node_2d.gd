class_name GameArea
extends Control

@export var destination_options : Array[PackedScene]


signal change_scene
enum {TOP, BOTTOM, LEFT, RIGHT}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var buttons = {
		TOP: $Top,
		BOTTOM: $Bottom,
		LEFT: $Left,
		RIGHT: $Right
	}

	for dir in buttons.keys():
		if dir >= destination_options.size() or destination_options[dir] == null:
			buttons[dir].visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_top_pressed() -> void:
	emit_signal("change_scene", destination_options[TOP])

func _on_bottom_pressed() -> void:
	emit_signal("change_scene", destination_options[BOTTOM])

func _on_left_pressed() -> void:
	emit_signal("change_scene", destination_options[LEFT])

func _on_right_pressed() -> void:
	emit_signal("change_scene", destination_options[RIGHT])
