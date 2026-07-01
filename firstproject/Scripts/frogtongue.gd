extends Area2D
@onready var timer: Timer = $Timer
@onready var tonguecollision: CollisionShape2D = $tonguecollision
var button_pressed = false

func _ready() -> void:
	tonguecollision.call_deferred("set_disabled", true)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("tongue") and button_pressed == false:
		tonguecollision.call_deferred("set_disabled", false)
		button_pressed=true
		timer.start()


func _on_timer_timeout() -> void:
	button_pressed=false
