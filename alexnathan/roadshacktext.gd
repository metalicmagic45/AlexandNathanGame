extends Node

var dialogue = [
	"Where are we?",
	{
		"type": "choice",
		"options": [
			{
				"text": "Look around",
				"jump": "Searchflag"
			},
			{
				"text": "Look at the map for directions.",
				"jump": "NavFlag"
			},
			{
				"text": "Take a shit",
				"jump": "poopflag"
			}
		]
	},

	# Choice 1: Look around (SEARCH skill check)
	{
		"type": "skillcheck",
		"check_pass": "searchZ2_pass",
		"check_fail": "searchZ2_fail",
		"character": "get_character",
		"skill": "SEARCH",
		"jump": "flaggy1",
		"flag": "Searchflag"
	},
	{
		"type": "text",
		"text": "You find some footprints leading into the woods.",
		"condition": "searchZ2_pass",
		"flag": "flaggy1",
		"jump": "exitflag"
	},
	{
		"type": "text",
		"text": "I can't find or see anything.",
		"condition": "searchZ2_fail",
		"jump": "exitflag"
	},

	# Choice 2: Look at the map (NAVIGATE skill check)
	{
		"type": "skillcheck",
		"check_pass": "navZ2_pass",
		"check_fail": "navZ2_fail",
		"character": "get_character",
		"skill": "NAVIGATE",
		"jump": "flaggy2",
		"flag": "NavFlag"
	},
	{
		"type": "text",
		"text": "The map shows you're near a ranger station to the east.",
		"condition": "navZ2_pass",
		"flag": "flaggy2",
		"jump": "exitflag"
	},
	{
		"type": "text",
		"text": "The map is smudged and unreadable.",
		"condition": "navZ2_fail",
		"jump": "exitflag"
	},

	# Choice 3: Take a shit (POW stat check)
	{
		"type": "statcheck",
		"check_pass": "powZ2_pass",
		"check_fail": "powZ2_fail",
		"character": "get_character",
		"stat": "POW",
		"jump": "flaggy3",
		"flag": "poopflag"
	},
	{
		"type": "text",
		"text": "You relieve yourself successfully.",
		"condition": "powZ2_pass",
		"flag": "flaggy3",
		"jump": "exitflag"
	},
	{
		"type": "text",
		"text": "You strain too hard and pull something. Ouch.",
		"condition": "powZ2_fail",
		"jump": "exitflag"
	},
	# Exit
	{
		"type": "text",
		"text": "You continue on your journey.",
		"flag": "exitflag"
	}
]
