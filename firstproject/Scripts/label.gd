extends Label
var stringy = ""
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "This is a Game made by"
	timer.start()



func _on_timer_timeout() -> void:
	text = "ShouvDick, Trueren, and Goatmar"
