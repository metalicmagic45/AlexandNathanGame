extends Node

var items = {}

func _ready() -> void:
	items["Glock17"] = {
		"name": "Glock 17",
		"sprite": preload("res://Pictures/Weapons/g17.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"
	}
	items["HIPower"] = {
		"name": "Hi-Power",
		"sprite": preload("res://Pictures/Weapons/HiPower.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"
	}	
	items["berettaM9"] = {
		"name": "Beretta M9",
		"sprite": preload("res://Pictures/Weapons/m9.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"
	}
	items["colt1911"] = {
		"name": "Colt 1911",
		"sprite": preload("res://Pictures/Weapons/1911colt.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"		
	}
	items["ColtPython"] = {
		"name": "Colt Python",
		"sprite": preload("res://Pictures/Weapons/coltpython.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"
	}
	items["S&WModel29"] = {
		"name": "S&W Model 29",
		"sprite": preload("res://Pictures/Weapons/s&w model 29.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1"	
	}
	items["RugerMini-14"] = {
		"name": "Ruger Mini-14",
		"sprite": preload("res://Pictures/Weapons/Ruger Mini-14.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"		
	}
	items["Remington700"] = {
		"name": "Remington 700",
		"sprite": preload("res://Pictures/Weapons/remington 700.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"		
	}
	items["Marlin4445"] = {
		"name": "Marlin 4445",
		"sprite": preload("res://Pictures/Weapons/marlin 444s.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1"	
	}
	items["Rem870"] = {
		"name": "Rem 870",
		"sprite": preload("res://Pictures/Weapons/remmington870.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"		
	}
	items["m14"] = {
		"name": "M14",
		"sprite": preload("res://Pictures/Weapons/m14.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"
	}
	items["RugerN0.1"] = {
		"name": "Ruger No.1",
		"sprite": preload("res://Pictures/Weapons/Ruger Mini-14.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1"	
	}
	items["WeatherbyMarkV"] = {
		"name": "Weatherby Mark V",
		"sprite": preload("res://Pictures/Weapons/weatherby Mark V.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"	
	}
	items["axe"] = {
		"name": "Axe",
		"sprite": preload("res://Pictures/Weapons/axe.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1"
	}
	items["Machete"] = {
		"name": "Machete",
		"sprite": preload("res://Pictures/Weapons/machete.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1"	
	}
	
	#items[""] = {
		#"name": "",
		#"sprite": preload("res://Pictures/"),		
	#}
