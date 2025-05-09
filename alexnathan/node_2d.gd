class_name GameArea
extends Control

@export var destination_options : Array[PackedScene]
var text = {
	"case_1" : "blah blah blah",
	"case_2" : "asdd"
}
signal change_scene
enum {TOP, BOTTOM, LEFT, RIGHT}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
