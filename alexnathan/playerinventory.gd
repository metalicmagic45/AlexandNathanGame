extends Node

var player_inventories = {
	"Johnson": ["colt1911", "HIPower", "berettaM9", "Glock17", "m14", "axe"],
	"Tyler": [],
	"Anna": ["axe"],
	"Kate": []
}
func get_inventory(player_name: String) -> Array:
	return player_inventories.get(player_name, []) 
func delete_inventory_item(player_name: String, item: int) -> void:
	var inventory = player_inventories.get(player_name, null)
	if inventory != null and item >= 0 and item < inventory.size():
		inventory.erase(item)
func find_index(name: String, inventory : Array) -> int:
	for i in range(inventory.size()):
		if inventory[i] == name:
			return i
	return -1
