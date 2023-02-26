extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var squished = false
var text


# Called when the node enters the scene tree for the first time.
func _ready():
	text = $WordPlatformText


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if squished:
		text.scale.y = lerp(text.scale.y, 0.1, 0.2)
	else:
		text.scale.y = lerp(text.scale.y, 1, 0.2)

func _physics_process(delta):
	squished = false
	for body in get_overlapping_bodies():
		if "Player" in body.name:
			if previous_pressed_status == false:
				if impartEmotion:
					body.currentEmotion = emotion
				if playSound:
					get_parent().get_parent().get_node("AudioStreamPlayer").play(false)	
					get_parent().get_parent().get_node("AudioStreamPlayer")
					
					
			pressed = true
