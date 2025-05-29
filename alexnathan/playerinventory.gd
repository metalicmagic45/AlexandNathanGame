extends Node

var player_inventories = {
	"Johnson": ["colt1911", "HIPower", "berettaM9", "Glock17", "m14", "axe"],
	"Tyler": [],
	"Anna": ["axe"],
	"Kate": []
	}
func get_inventory(player_name: String) -> Array:
	return player_inventories[player_name]  # NOT .duplicate()

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
	
