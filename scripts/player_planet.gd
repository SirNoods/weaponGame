extends Node2D

var health = 100
var energy = 50
var projectile_scene = preload("res://scenes/basic_projectile.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Something cool is happening, probably.")
	print("player_planet node ready.")
	print(projectile_scene)
	print(projectile_scene is PackedScene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Get the mouse position in global coordinates
	var mouse_position = get_global_mouse_position()
	
	# Rotate the aim indicator to point at the mouse
	$AimIndicator.look_at(mouse_position)
	
	# rotation number two to offset this, because I am an idiot
	$AimIndicator.rotation += PI / 2

func on_shoot():
	"""
	Shooting Zone, get ready to fuck
	"""
	# Calculate direction
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()  

	# offset the projectile so it doesn't spawn in the middle of the planet
	var sprite_size = $AimIndicator.texture.get_size() * $AimIndicator.scale
	var aim_offset = Vector2(sprite_size.x / 2, 0)	
	# Rotate the offset by -90 degrees because I am an idiot who didn't think of forward axis
	aim_offset = aim_offset.rotated(-PI / 2)
	var aim_end_position = $AimIndicator.global_position + aim_offset.rotated($AimIndicator.rotation)

	# Debuging prints because I went briefly insane
	print("Direction: ", direction)
	print("Aim End Position: ", aim_end_position)
	
	# Create the projectile
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)	
	# offset position
	projectile.global_position = aim_end_position	
	# Set projectile direction
	projectile.direction = direction

	# Another debugging print for the same reason as above
	print("Projectile created at ", aim_end_position)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		on_shoot()
		print("pew pew")

func take_damage(amount):
	health -= amount

func use_energy(amount):
	if energy >= amount:
		energy -= amount
		return true
	return false
