extends CharacterBody2D

@onready var floor_cast: RayCast2D = $FloorCast
@onready var wall_cast: RayCast2D = $WallCast

const SPEED = 50.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_landed: bool = false
var is_turning: bool = false # <-- NEW: The silver bullet to stop the spin

func _physics_process(delta: float) -> void:
	
	# 1. FALLING STATE
	if not has_landed:
		velocity.y += gravity * delta
		if floor_cast.is_colliding() or is_on_floor():
			has_landed = true
			velocity.y = 0 
			
	# 2. CRAWLING STATE
	else:
		# Only check raycasts if we are NOT in the middle of a turn
		if not is_turning:
			
			# INSIDE CORNERS
			if wall_cast.is_colliding():
				rotation_degrees -= 90
				start_turn_cooldown() # Lock raycasts temporarily
				
			# OUTSIDE CORNERS
			elif not floor_cast.is_colliding():
				rotation_degrees += 90
				start_turn_cooldown() # Lock raycasts temporarily

		# MOVEMENT (Always push forward and pull down)
		var forward_movement = transform.x * SPEED
		var sticky_gravity = transform.y * 250.0 
		
		velocity = forward_movement + sticky_gravity
		
	move_and_slide()

# This function temporarily blinds the raycasts so the snail can't spin
func start_turn_cooldown() -> void:
	is_turning = true
	
	# Wait for 0.15 seconds. This gives sticky_gravity exactly enough time
	# to slam the snail onto the new wall before checking raycasts again.
	await get_tree().create_timer(0.3).timeout
	
	is_turning = false
