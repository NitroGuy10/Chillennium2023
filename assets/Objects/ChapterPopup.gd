extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var falling = false
var yVelocity = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$StayTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if falling:
		yVelocity += 10000 * delta
		position.y += yVelocity * delta


func _on_StayTimer_timeout():
	$DespawnTimer.start()
	falling = true


func _on_DespawnTimer_timeout():
	queue_free()
	get_parent().get_node("EmotionFlyup").visible = true
	
