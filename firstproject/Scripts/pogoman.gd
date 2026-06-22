extends Node2D


# --- NODES ---
@onready var main_body: RigidBody2D = $MainBody
@onready var ground_check: RayCast2D = $Ground
@onready var pogo_tip: RigidBody2D = $PogoTip

# --- FORCES ---
@export var torque_power: float = 25000.0 # Increased because MainBody is heavier now
@export var min_jump_impulse: float = 1000.0
@export var max_jump_impulse: float = 4000.0
@export var charge_speed: float = 5000.0

var current_charge: float = 0.0

func _physics_process(delta: float) -> void:
	# Keep the ground check RayCast aligned with the pogo stick
	ground_check.global_position = main_body.global_position
	ground_check.target_position = Vector2.DOWN.rotated(main_body.rotation) * 50 # Adjust length to reach past the tip
	
	pogo_tip.global_rotation = main_body.global_rotation
	
	_handle_rotation()
	_handle_jumping(delta)

func _handle_rotation() -> void:
	var tilt = Input.get_axis("lean_left", "lean_right")
	
	if tilt != 0:
		# Apply twisting force ONLY to the heavy main body
		main_body.apply_torque(tilt * torque_power)

func _handle_jumping(delta: float) -> void:
	if ground_check.is_colliding():
		if Input.is_action_pressed("jump"):
			current_charge += charge_speed * delta
			current_charge = clamp(current_charge, min_jump_impulse, max_jump_impulse)
			
		elif Input.is_action_just_released("jump"):
			# Launch the main body upwards
			var jump_direction = Vector2.UP.rotated(main_body.rotation)
			main_body.apply_central_impulse(jump_direction * current_charge)
			current_charge = 0.0
	else:
		if not Input.is_action_pressed("jump"):
			current_charge = 0.0
