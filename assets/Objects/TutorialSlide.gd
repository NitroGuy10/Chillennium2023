extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var yVelocity = 0
var playSound = false

export var entering = false
export var exiting = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entering:
		if not playSound:
			playSound = true
			$AudioStreamPlayer.play()
		position.y = lerp(position.y, 0, 6 * delta)
	
	if exiting:
		entering = false		
		if position.y > 2300:
			queue_free()
		else:
			yVelocity += 10000 * delta
	
	position.y += yVelocity * delta
	


func _on_ExitTimer_timeout():
	exiting = true
