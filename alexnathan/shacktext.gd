extends Node
var areaID = 2
var areaname = "shack"

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
	"That was a short convo",
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
