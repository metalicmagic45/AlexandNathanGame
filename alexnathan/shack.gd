extends Control

@onready var Top_Button = null
@onready var Right_Button = load("res://roadshack.tscn")
@onready var Left_Button = null
@onready var Bottom_Button = null
@onready var shacktext = load("res://shacktext.gd").new()
@onready var areaID = shacktext.areaID

func get_ID():
	return areaID

func get_top():
	return Top_Button
func get_right():
	return Right_Button
func get_left():
	return Left_Button
func get_bottom():
	return Bottom_Button
