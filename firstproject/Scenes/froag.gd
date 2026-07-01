extends CharacterBody2D
@onready var pivot: Node = $Pivot
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			$Pivot.scale.x = 1 
		elif direction < 0:
			$Pivot.scale.x = -1
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
