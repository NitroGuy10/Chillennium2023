extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var isPlayer2 = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if not isPlayer2:
		$Heart/AnimatedSprite.animation = "explode"
		$Heart.visible = false
		$PlayerKinematicBody2D/AnimatedSprite.modulate = Color(0.6, 0.6, 1)		
	else:
		$PlayerKinematicBody2D/AnimatedSprite.modulate = Color(1, 0.6, 0.6)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
