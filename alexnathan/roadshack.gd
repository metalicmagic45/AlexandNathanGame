extends Control

@onready var Top_Button = null
@onready var Right_Button = null
@onready var Left_Button = null
@onready var Bottom_Button = load("res://CarWilderness.tscn")

func get_top():
	return Top_Button
func get_right():
	return Right_Button
func get_left():
	return Left_Button
func get_bottom():
	return Bottom_Button
