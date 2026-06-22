extends CharacterBody2D
@onready var hitboxcollision: CollisionShape2D = $hitbox/hitboxcollision
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var spint=false

func _on_hitbox_body_entered(body: Node2D) -> void:
	hitboxcollision.set_deferred("disabled", true)
	spint=true

func _physics_process(delta: float) -> void:
	if spint:
		animated_sprite.rotation +=1
		scale.x+=1
		scale.y+=1

	
