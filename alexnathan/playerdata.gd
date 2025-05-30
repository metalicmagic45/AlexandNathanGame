extends Node
#Global varriable that BottemUi and CharacterSheet refrence, default is Johnson or who ever you would start the game playing as
#Use Local varriables to either change the global varriable or to update information bassed on the currently selected character
var CurrentCharacter: String = "Johnson"

func get_skill(name: String, skill: String) -> int:
	if players.has(name):
		var char_data = players[name]
		if char_data.has("skills") and char_data["skills"].has(skill):
			return char_data["skills"][skill]
		else:
			print("Skill not found")
	else:
		print("Character not found")
	return -1
func get_stat(name: String, stat: String) -> int:
	if players.has(name):
		var char_data = players[name]
		if char_data.has(stat):
			return char_data[stat]
		else:
			print("Stat not found")
	else:
		print("Character not found")
	return -1

var players = {
	"Johnson": {
		"name": "Johnson",
		"sprite": preload("res://Pictures/JhonsonPortrait.png"),
		"HP": 14,
		"Current_HP": 14,
		"MP": 10,
		"Current_MP": 0,
		"STR": 14,
		"CON": 14,
		"DEX": 14,
		"POW": 10,
		"INT": 10,
		"LUCK": 10,
		"skills": {
			"Alertness": 40,
			"Athletics": 40,
			"COMPUTERSCIENCE": 5,
			"CRIMINOLOGY": 5,
			"CRAFT": 40,
			"DODGE": 35,
			"RESEARCH": 5,
			"DRIVE": 50,
			"FIREARMS(PISTOL)": 60,
			"FIREARMS(SHOT/RIFLE)": 60,
			"FIRSTAID": 20,
			"MACHINERY": 30,
			"HISTORY": 5,
			"LAW": 5,
			"MELEEWEAPONS": 20,
			"NAVIGATE": 40,
			"PERSUADE": 5,
			"SLIGHTOFHAND": 5,
			"SURVIVAL": 50,
			"STEALTH": 50,
			"UNARMED": 50,
			"SWIM": 20,
			"SEARCH": 30,
			"UNATURAL": 1,
			"SCIENCE": 5,
			"MEDCINE": 5,
		}
	},
	"Anna": {
		"name": "Anna",
		"sprite": preload("res://Pictures/AnnaPortrait.png"),
		"HP": 11,
		"Current_HP": 11,
		"MP": 10,
		"Current_MP": 0,
		"STR": 10,
		"CON": 11,
		"DEX": 10,
		"POW": 17,
		"INT": 15,
		"LUCK": 14,
		"skills": {
			"Alertness": 30,
			"Athletics": 30,
			"COMPUTERSCIENCE": 30,
			"CRIMINOLOGY": 60,
			"CRAFT": 5,
			"DODGE": 25,
			"RESEARCH": 50,
			"DRIVE": 40,
			"FIREARMS(PISTOL)": 5,
			"FIREARMS(SHOT/RIFLE)": 5,
			"FIRSTAID": 30,
			"MACHINERY": 5,
			"HISTORY": 40,
			"LAW": 60,
			"MELEEWEAPONS": 5,
			"NAVIGATE": 30,
			"PERSUADE": 60,
			"SLIGHTOFHAND": 5,
			"SURVIVAL": 5,
			"STEALTH": 5,
			"UNARMED": 5,
			"SWIM": 30,
			"SEARCH": 40,
			"UNATURAL": 1,
			"SCIENCE": 30,
			"MEDCINE": 10		
		}
	},
	"Tyler": {
		"name": "Tyler",
		"sprite": preload("res://Pictures/TylerPortrait.png"),
		"HP": 12,
		"Current_HP": 12,
		"MP": 10,
		"Current_MP": 0,
		"STR": 12,
		"CON": 12,
		"DEX": 10,
		"POW": 10,
		"INT": 17,
		"LUCK": 10,
		"skills": {
			"Alertness": 60,
			"Athletics": 20,
			"COMPUTERSCIENCE": 50,
			"CRIMINOLOGY": 50,
			"CRAFT": 5,
			"DODGE": 25,
			"RESEARCH": 50,
			"DRIVE": 30,
			"FIREARMS(PISTOL)": 30,
			"FIREARMS(SHOT/RIFLE)": 30,
			"FIRSTAID": 5,
			"MACHINERY": 5,
			"HISTORY": 5,
			"LAW": 40,
			"MELEEWEAPONS": 15,
			"NAVIGATE": 30,
			"PERSUADE": 30,
			"SLIGHTOFHAND": 45,
			"SURVIVAL": 5,
			"STEALTH": 20,
			"UNARMED": 20,
			"SWIM": 15,
			"SEARCH": 60,
			"UNATURAL": 1,
			"SCIENCE": 50,
			"MEDCINE": 5		
		}
	},
	"Kate": {
		"name": "Kate",
		"sprite": preload("res://Pictures/KatePortrait.png"),
		"HP": 10,
		"Current_HP": 10,
		"MP": 10,
		"Current_MP": 0,
		"STR": 10,
		"CON": 10,
		"DEX": 12,
		"POW": 15,
		"INT": 16,
		"LUCK": 15,
		"skills": {
			"Alertness": 60,
			"Athletics": 20,
			"COMPUTERSCIENCE": 20,
			"CRIMINOLOGY": 5,
			"CRAFT": 30,
			"DODGE": 30,
			"RESEARCH": 50,
			"DRIVE": 30,
			"FIREARMS(PISTOL)": 5,
			"FIREARMS(SHOT/RIFLE)": 5,
			"FIRSTAID": 65,
			"MACHINERY": 5,
			"HISTORY": 30,
			"LAW": 20,
			"MELEEWEAPONS": 10,
			"NAVIGATE": 20,
			"PERSUADE": 40,
			"SLIGHTOFHAND": 25,
			"SURVIVAL": 5,
			"STEALTH": 5,
			"UNARMED": 5,
			"SWIM": 25,
			"SEARCH": 50,
			"UNATURAL": 1,
			"SCIENCE": 50,
			"MEDCINE": 65		
		}
	}
}
