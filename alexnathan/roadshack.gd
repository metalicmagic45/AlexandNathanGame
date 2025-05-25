extends Control

@onready var Top_Button = null
@onready var Right_Button = null
@onready var Left_Button = null
@onready var Bottom_Button = get_node("res://CarWilderness.tscn")  # or whatever node name is correct

func get_top():
	return Top_Button
func get_right():
	return Right_Button
func get_left():
	return Left_Button
func get_bottom():
	return Bottom_Button
