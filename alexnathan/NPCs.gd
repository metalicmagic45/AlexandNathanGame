extends Node

var bob = load("res://bob.gd").new()

var NPCs = {
	"Bob": {
		"char_dialogue": bob.char_dialogue,
		"sprite": preload("res://Pictures/Cop.png")
	}
	
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
