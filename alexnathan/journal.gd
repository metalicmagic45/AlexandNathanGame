extends Node

signal journal_entry_added

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
func add_journal_entry(id: String, title: String, description: String, status: String = "Incomplete") -> void:
	journal_entries[id] = {
		"title": title,
		"status": status,
		"description": description
	}
	emit_signal("journal_entry_added")
func edit_journal_status(id: String, new_status: String) -> void:
	if journal_entries.has(id):
		journal_entries[id]["status"] = new_status
func get_journal_entry(id : String):
	if journal_entries.has(id):
		return journal_entries[id]
	else:
		print("Journal Entry Not Found")
		return
