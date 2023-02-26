extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var credits = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	$Timer2.start()	
	$AnimatedSprite.play()
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if credits:
		$AnimatedSprite2/Sprite.position.y -= 50 * delta


func _on_Timer_timeout():
	$WordPlatformText.visible = true


func _on_Timer2_timeout():
	$AnimatedSprite2.visible = true
	$AudioStreamPlayer2.play()
	credits = true
