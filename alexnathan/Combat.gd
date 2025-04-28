extends Node
@onready var dice_output = get_node("CanvasLayer2/Control/DiceOutput")
@onready var dice_list = []
var dice_roll_total = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#initilizes random number and creates a instantse of the random class
	var random = RandomNumberGenerator.new()
	random.randomize()
	dice_list.append_array(["d6", "d4", "d6", "d8", "d10", "d12"])
	dice_roll_calculator()
	
#Dice functions
func dice_roll_calculator():
	for dice in dice_list:
		print(dice)
		if dice == "d4":
			dice_roll_total += randi_range(1, 4)
		if dice == "d6":
			dice_roll_total += randi_range(1, 6)
		if dice == "d8":
			dice_roll_total += randi_range(1, 8)
		if dice == "d10":
			dice_roll_total += randi_range(1, 10)
		if dice == "d12":
			dice_roll_total += randi_range(1, 12)
	dice_output.text = str(dice_roll_total)
	
	
	
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
