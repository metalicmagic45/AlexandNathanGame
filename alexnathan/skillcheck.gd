extends Node

func _ready() -> void:
	randomize()

func dice_roll() -> int:
	return randi_range(1,100)
func skill_check(DC : int, roll : int) -> bool:
	if roll <= DC:
		return true
	else: 
		return false
func stat_check(DC : int, roll : int) -> bool:
	var DC2 = DC * 5
	if roll <= DC2:
		return true
	else:
		return false
