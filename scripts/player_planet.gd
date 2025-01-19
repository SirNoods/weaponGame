extends Node2D

var health = 100
var energy = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Something cool is happening, probably.") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	"""
	Aim Indicator
	"""
	# Get the mouse position in global coordinates
	var mouse_position = get_global_mouse_position()
	
	# Rotate the aim indicator to point at the mouse
	$AimIndicator.look_at(mouse_position)
	
	# rotation number two to offset this, because I am an idiot
	$AimIndicator.rotation += PI/2

func take_damage(amount):
	health -= amount

func use_energy(amount):
	if energy >= amount:
		energy -= amount
		return true
	return false
