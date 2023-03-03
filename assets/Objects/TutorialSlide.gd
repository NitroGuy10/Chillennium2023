extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var yVelocity = 0

export var entering = true
export var exiting = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entering:
		if position.y > 0:
			position.y = 0
			entering = false
		else:
			yVelocity += 10000 * delta
			position.y += yVelocity * delta
