extends Node
var areaID = 0
var areaname = "Carwildernessstart"
		
	
var Area1 = [
	{
		"type": "jump",
		"conditions": ["OR:met_johnson,rejected_convo,asked_where_am_i"],
		"jump": "conditionflag",
		"set_flag": "jump1condtion"
	},
	"Johnson: Hello, how are you?",
	"Kate: Doing great, thanks for asking.",
	{
		"type": "choice",
		"options": [
			{
				"text": "I'm good!",
				"jump": "flag1",
				"set_flag": "met_johnson",
				"talking" : "Anna",
			},
			{
				"text": "Leave me alone.",
				"jump": "flag2",
				"set_flag": "rejected_convo",
				"talking" : "Kate",
			},
			{
				"text": "Where am I?",
				"jump": "flag3",
				"set_flag": "asked_where_am_i",
				"talking" : "Tyler",
			}
		]
	},
	{ #index 3
		"type": "text",
		"text": "Johnson: Glad to hear it.",
		"jump": "flag4",
		"flag": "flag1",
		"talking" : "Jhonson",
	},
	{ #index 4
		"type": "text",
		"text": "Johnson: Oh... okay then.",
		"jump": "flag4",
		"flag": "flag2",
		"talking" : "Jhonson",
	},
	{ #index 5
		"type": "text",
		"text": "Johnson: You're in the wilderness.",
		"condition": "asked_where_am_i",
		"jump": "flag4",
		"flag": "flag3",
		"talking" : "Jhonson",
	},
	{ #index 6
		"type": "text",
		"text": "Let's just go.",
		"flag": "flag4"
	},
	"Let's check the bush", #index 7
	{ #index 8
		"type": "choice",
		"options": [
			{
				"text": "Study the Plant [Int]",
				"jump": "flag5"
			},
			{
				"text": "Eat the Plant [Con]",
				"jump": "flag6"
			},
			{
				"text": "Attack the Plant [Str]",
				"jump": "flag7"
			}
		]
	},	
	{ #index 8
		"type": "skillcheck",
		"check_pass": "Bush_SearchZ1_pass",
		"check_fail": "Bush_SearchZ1_fail",
		"character": "get_character",
		"skill": "SEARCH",
		"DC": 14,
		"jump": "flag8",
		"flag": "flag5"
	},
	{ #index 9	
		"type": "skillcheck",
		"check_pass": "Bush_SearchZ1_pass",
		"check_fail": "Bush_SearchZ1_fail",
		"character": "get_character",
		"skill": "CON",
		"DC": 14,
		"jump": "flag8",
		"flag": "flag6"
	},
	{ #index 10	
		"type": "skillcheck",
		"check_pass": "Bush_SearchZ1_pass",
		"check_fail": "Bush_SearchZ1_fail",
		"character": "get_character",
		"skill": "UNARMED",
		"DC": 14,
		"jump": "flag8",
		"flag": "flag7"
	},
	{ #index 11
		"type": "text",
		"text": "I found a boot",
		"condition": "Bush_SearchZ1_pass",
		"flag": "flag8"
	},
	{ #index 12
		"type": "text",
		"text": "I found nothing",
		"condition": "Bush_SearchZ1_fail"
	},
	"Let's try to lift this rock.",
	{
		"type": "skillcheck",
		"check_pass": "STRCHECKZ1_pass",
		"check_fail": "STRCHECKZ1_fail",
		"character": "get_character",
		"skill": "ATHLETICS",
		"DC": 14
	},
	{
		"type": "text",
		"text": "I lifted it.",
		"condition": "STRCHECKZ1_pass"
	},
	{
		"type": "text",
		"text": "I couldn't lift it.",
		"condition": "STRCHECKZ1_fail",
	},
	{
		"type": "STOP"
	},
	{
		"type": "text",
		"text": "You passed previous checks, so you reached this jump",
		"flag": "conditionflag",
		"condition": "jump1condtion"
	}
	
		
]
