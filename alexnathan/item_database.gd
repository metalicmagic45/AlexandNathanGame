extends Node

var items = {}

func _ready() -> void:
	items["Glock17"] = {
		"name": "Glock 17",
		"sprite": preload("res://Pictures/Weapons/g17.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Polymer-framed 9mm service pistol."
	}
	items["HIPower"] = {
		"name": "Hi-Power",
		"sprite": preload("res://Pictures/Weapons/HiPower.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Classic 9mm with a high-capacity mag."
	}	
	items["berettaM9"] = {
		"name": "Beretta M9",
		"sprite": preload("res://Pictures/Weapons/m9.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Standard US military sidearm."
	}
	items["colt1911"] = {
		"name": "Colt 1911",
		"sprite": preload("res://Pictures/Weapons/1911colt.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": ".45 caliber American classic."
	}
	items["ColtPython"] = {
		"name": "Colt Python",
		"sprite": preload("res://Pictures/Weapons/coltpython.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": ".357 Magnum revolver."
	}
	items["S&WModel29"] = {
		"name": "S&W Model 29",
		"sprite": preload("res://Pictures/Weapons/s&w model 29.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": ".44 Magnum powerhouse."
	}
	items["RugerMini-14"] = {
		"name": "Ruger Mini-14",
		"sprite": preload("res://Pictures/Weapons/Ruger Mini-14.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Versatile semi-auto ranch rifle."
	}
	items["Remington700"] = {
		"name": "Remington 700",
		"sprite": preload("res://Pictures/Weapons/remington 700.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Bolt-action favorite for snipers."
	}
	items["Marlin4445"] = {
		"name": "Marlin 4445",
		"sprite": preload("res://Pictures/Weapons/marlin 444s.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Big-bore lever-action hunting rifle."
	}
	items["Rem870"] = {
		"name": "Rem 870",
		"sprite": preload("res://Pictures/Weapons/remmington870.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Reliable 12-gauge pump shotgun."
	}
	items["m14"] = {
		"name": "M14",
		"sprite": preload("res://Pictures/Weapons/m14.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Battle-proven, semi-auto rifle."
	}
	items["RugerN0.1"] = {
		"name": "Ruger No.1",
		"sprite": preload("res://Pictures/Weapons/Ruger Mini-14.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Single-shot precision hunting rifle."
	}
	items["WeatherbyMarkV"] = {
		"name": "Weatherby Mark V",
		"sprite": preload("res://Pictures/Weapons/weatherby Mark V.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "High-powered, ultra-smooth bolt gun."
	}
	items["axe"] = {
		"name": "Axe",
		"sprite": preload("res://Pictures/Weapons/axe.png"),
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Heavy tool for chopping wood—or skulls."
	}
	items["Machete"] = {
		"name": "Machete",
		"sprite": preload("res://Pictures/Weapons/machete.png"),	
		"dmg": "2d6",
		"range": "1",
		"cost": "1",
		"text": "Broad-bladed jungle blade."
	}
	items["MagicSword"] = {
		"name": "Mysterious Sword",
		"sprite": preload("res://Pictures/MagicSword.png"),
		"type": "MagicItem",
		"Active": "This sword has the capabilities to seal the unatural.",
		"Passive": "Deals double damage and ignores armor from the unatural.",
		"text": "1800s Colonial Spanish Sword"
	}
	items["MagicRing"] = {
		"name": "Mysterious Ring",
		"sprite": preload("res://Pictures/MagicRing.png"),
		"type": "MagicItem",
		"Active": "Ring has the ability to shield from basic unatural effects.",
		"Passive": "5% Boost to POW checks",
		"text": "Looted from a grave"
	}
