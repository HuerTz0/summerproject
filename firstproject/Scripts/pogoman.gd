extends RigidBody2D
#Phys Variables

@export var torque_power: float = 15000.0

#Jump Variables
@export var min_jump_imp: float = 300.0;
@export var max_jump_imp: float = 1200.0;
@export var charge_up: float = 1500.0;

var current_charge: float = 0.0;
@onready var pogo_tip: RayCast2D = $pogoTip;

func _physics_process(delta: float) -> void:
	_handle_rotation()
	_handle_jumping(delta)


func _handle_rotation() -> void:
	var tilt = Input.get_axis("lean_left", "lean_right")
	if tilt != 0:
		apply_torque(tilt*torque_power)

func _handle_jumping(delta: float) -> void:
	if pogo_tip.is_colliding():
		if Input.is_action_pressed("jump"):
			current_charge += charge_up*delta
			current_charge = clamp(current_charge, min_jump_imp, max_jump_imp)
		elif Input.is_action_just_released("jump"):
			var jump_direction = Vector2.UP.rotated(rotation)
			apply_central_impulse(jump_direction*current_charge)
			current_charge = 0.0
		if not Input.is_action_pressed("jump"):
			current_charge = 0.0
			
