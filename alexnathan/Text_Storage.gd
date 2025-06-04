extends Node
#have a varialbe that acts as an identifier which signls when the player can make a diolouge choice
var Diolouge_Choice_Toggle = false
#Array inside of an array, index the first array for the group of diolouge that you want and then index the specific dioloughe that you want	
var CarwildernessScript = load("res://carwildernesstext.gd").new()
var roadshack = load("res://roadshacktext.gd").new()
var shack = load("res://shacktext.gd").new()

var Area1 = CarwildernessScript.Area1
var Area2 = roadshack.dialogue
var Area3 = shack.dialogue
var Area4 = []
var Area5 = []
var Gameplay_Area_Selecter = [Area1, Area2, Area3, Area4, Area5]
#Text.append()
