extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var isPlayer2 = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if isPlayer2:
		$Heart/AnimatedSprite.animation = "explode"
		$Heart.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
