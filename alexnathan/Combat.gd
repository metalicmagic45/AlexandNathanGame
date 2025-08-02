extends Node
@onready var dice_output = get_node("CanvasLayer2/Control/DiceOutput")
@onready var dice_list = []
var dice_roll_total = 0
# Called when the node enters the scene tree for the first time.

func roll_item_damage(item_key_dmg : String) -> int:
		var dmg_str = item_key_dmg
		var parts = dmg_str.split("d")
		var num_dice = int(parts[0])
		var sides = int(parts[1])
		var total = 0
		for i in num_dice:
			var temp = randi_range(1, sides)
			total = total + temp
		return total
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#Dice test function
#func dice_roll_calculator():
	#var d4_total = 0
	#var d6_total = 0
	#var d8_total = 0
	#var d10_total = 0
	#var d12_total = 0
	#
	#for dice in dice_list:
		#print(dice)
		#if dice == "d4":
			#d4_total += randi_range(1, 4)
		#if dice == "d6":
			#d6_total += randi_range(1, 6)
		#if dice == "d8":
			#d8_total += randi_range(1, 8)
		#if dice == "d10":
			#d10_total += randi_range(1, 10)
		#if dice == "d12":
			#d12_total += randi_range(1, 12)
	#dice_roll_total = d4_total + d6_total + d8_total + d10_total + d12_total
	#print(d4_total, d6_total, d8_total, d10_total, d12_total)
	#dice_output.text = str(dice_roll_total)
