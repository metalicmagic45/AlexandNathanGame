extends Node

var equiped_items = ["MagicRing"]

var player_inventories = {
	"William Clark": [	"Glock17",
	"HIPower",
	"berettaM9",
	"colt1911",
	"ColtPython",
	"S&WModel29",
	"MagicSword",
	"MagicRing"],
	}
	
func _ready() -> void:
	equiped_item_effects()
	
func get_inventory(player_name: String) -> Array:
	if player_inventories.has(player_name):
		return player_inventories[player_name]
	else:
		print("Warning: Inventory not found for player '%s'" % player_name)
		return []  # Return empty inventory as fallback


func delete_inventory_item(player_name: String, index: int) -> void:
	player_inventories[player_name].remove_at(index)   # <─ one reference, no copy

	
func find_index(name: String, inventory : Array) -> int:
	for i in range(inventory.size()):
		if inventory[i] == name:
			return i
	return -1
func print_inventory(inventory : Array) -> void:
	for i in range(inventory.size()):
		print(inventory[i])
	return
func get_magic_items() -> Array:
	var magic_items = []
	for player_name in player_inventories.keys():
		var inventory = player_inventories[player_name]
		for item_name in inventory:
			if ItemDatabase.items.has(item_name) and ItemDatabase.items[item_name].get("type", "") == "MagicItem":
				magic_items.append(item_name)
	return magic_items

#Get modifier from equiped items and then add them to playerdata
func equiped_item_effects():
	var effect
	var effected_stat
	for item in equiped_items:
		effect = ItemDatabase.items[item]["effect"]
		effected_stat = ItemDatabase.items[item]["effected_stat"]
		Playerdata.character_stat_update(effected_stat, effect)
		#Playerdata.CurrentCharacter
	
