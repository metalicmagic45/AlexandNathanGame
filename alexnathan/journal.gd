extends Node

var journal_entries = {
	"MissionReport": {
		"title": "Operation Hollow Butcher",
		"status": "Incomplete",
		"description": """
		You have been ordered to investigate the disappearance of Regan Hilstad, 
		secure occult and supernatural items possessed by the cult, gather intelligence of the cult, 
		assess threat level, and report findings for potential escalation.
		"""
	}
		
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func get_journal():
	return journal_entries
