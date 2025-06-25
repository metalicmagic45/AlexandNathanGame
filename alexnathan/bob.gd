extends Node

var sprite = preload("res://Pictures/Cop.png")


var char_dialogue = [
	{
		"type": "Display",
		"chartype": "NPC",
		"character": "Bob",
		"direction": "left"
	},
	"hello",
	{
		"type": "text",
		"text": "I saw a corpse in this shack some time ago.",
		"add_journal": {
			"id": "Corpse1",
			"title": "The Mysterious Corpse",
			"status": "Incomplete",
			"description": "Bob told us that there was a corpse in this shack. Could this be connected with the cult?"
		}
	},
	"Goodbye",
	{
		"type": "RemoveDisplay",
		"direction": "left"
	},
	{
		"type": "STOP"
	}
]
