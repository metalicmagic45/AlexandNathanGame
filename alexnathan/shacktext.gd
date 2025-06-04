extends Node
var areaID = 2

var dialogue = [
	"There a person in this shack",
	{
		"type": "choice",
		"options": [
			{
				"text": "Talk to him",
				"jump": "Talkflag"
			},
			{
				"text": "Ignore him",
				"jump": "LeaveFlag"
			}
		]
	},
	{	"type": "NPC",
		"character": "Bob",
		"flag": "Talkflag",
	},
	{
		"type": "STOP"
	},
	{
		"type": "text",
		"text": "Nothing to see",
		"flag": "LeaveFlag"
	},
	{
		"type": "STOP"
	}
]
