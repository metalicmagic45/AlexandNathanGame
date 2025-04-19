extends Node

var player_inventories = {
	"Johnson": ["colt1911", "HIPower", "berettaM9", "Glock17", "m14", "axe"],
	"Tyler": [],
	"Anna": ["axe"],
	"Kate": []
}
func get_inventory(player_name: String) -> Array:
	return player_inventories.get(player_name, []) 
