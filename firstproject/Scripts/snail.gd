extends CharacterBody2D

@onready var floor_cast: RayCast2D = $FloorCast
@onready var wall_cast: RayCast2D = $WallCast

const SPEED = 50.0
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var has_landed: bool = false

func _physics_process(delta: float) -> void:
	
	if not has_landed:
		velocity.y += gravity * delta
		if floor_cast.is_colliding() or is_on_floor():
			has_landed = true
			velocity.y = 0 
	else:
		if wall_cast.is_colliding():
			rotation -= PI / 2
			break
		elif not floor_cast.is_colliding():
			rotation += PI/2
			break
		

		var forward_movement = transform.x * SPEED
		
		var sticky_gravity = transform.y * 250.0 
		
		velocity = forward_movement + sticky_gravity
		
	move_and_slide()
