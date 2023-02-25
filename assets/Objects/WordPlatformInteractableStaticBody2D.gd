extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var pressedColor = Color(1.0, 1.0, 1.0)

var pressed = false
var text


# Called when the node enters the scene tree for the first time.
func _ready():
	text = get_parent().get_parent().get_node("WordPlatformText")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pressed:
		text.position.y = lerp(text.position.y, 0, 0.2)
	else:
		text.position.y = lerp(text.position.y, -10, 0.2)

func _physics_process(delta):
	pressed = false
	for body in get_overlapping_bodies():
		if "Player" in body.name:
			pressed = true
	
