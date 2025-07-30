extends Node
#Global varriable that BottemUi and CharacterSheet refrence, default is Johnson or who ever you would start the game playing as
#Use Local varriables to either change the global varriable or to update information bassed on the currently selected character
var CurrentCharacter: String = "William Clark"

func get_skill(name: String, skill: String) -> int:
	if players.has(name):
		var char_data = players[name]
		if char_data.has("skill_modifiers") and char_data["skill_modifiers"].has(skill):
			return char_data["skill_modifiers"][skill]
		else:
			print("Skill not found")
	else:
		print("Character not found")
	return -1
#func get_stat(name: String, stat: String) -> int:
	#if players.has(name):
		#var char_data = players[name]
		#if char_data.has(stat):
			#return char_data[stat]
		#else:
			#print("Stat not found")
	#else:
		#print("Character not found")
	#return -1
	
func character_stat_update(effected_stat, effect):
	var current_value_of_skill
	
	#Gets the to be updated stat's current value and adds the amount to be modifed
	current_value_of_skill = players[CurrentCharacter]["skill_modifiers"][effected_stat]
	current_value_of_skill = current_value_of_skill + effect
	#Updates the current skill to the current amount
	players[CurrentCharacter]["skill_modifiers"][effected_stat] = current_value_of_skill
	#print(current_value_of_skill)
	print("Updated stat is ", effected_stat, ", Amount increased by is ", effect, ", New stat amount is: ", players[CurrentCharacter]["skill_modifiers"][effected_stat])
	
var players = {
	"William Clark": {
		"name": "William Clark",
		"sprite": preload("res://Pictures/William Clark.png"),
		"HP": 14,
		"Current_HP": 14,
		"MP": 10,
		"Current_MP": 0,
		"STR": 14,
		"CON": 14,
		"DEX": 14,
		"INT": 10,
		"WIL": 12,
		"skill_modifiers": {
			"STR": 2,
			"CON": 2,
			"DEX": 2,
			"INT": 0,
			"WIL": 1,
			"ALERTNESS": 2,
			"ATHLETICS": 2,
			"COMPUTERSCIENCE": 2,
			"CRIMINOLOGY": 2,
			"CRAFT": 2,
			"DODGE": 2,
			"RESEARCH": 2,
			"DRIVE": 2,
			"FIREARMS": 2,
			"FIRSTAID": 2,
			"MACHINERY": 2,
			"HISTORY": 2,
			"LAW": 2,
			"MELEEWEAPONS": 2,
			"NAVIGATE": 2,
			"PERSUADE": 2,
			"SLIGHTOFHAND": 2,
			"SURVIVAL": 2,
			"STEALTH": 2,
			"UNARMED": 2,
			"SWIM": 2,
			"SEARCH": 2,
			"UNATURAL": 2,
			"SCIENCE": 2,
			"MEDCINE": 2,
		}
	}
}
