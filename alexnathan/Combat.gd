extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#initilizes random number and creates a instantse of the random class
	var d6_random = RandomNumberGenerator.new()
	d6_random.randomize()
	print(randi_range(1, 6))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
