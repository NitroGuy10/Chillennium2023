extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var reloaded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Path2D/PathFollow2D.offset > 3300:
		get_parent().transitioning = false
		queue_free()
	else:
		if $Path2D/PathFollow2D.offset > 1300 and not reloaded:
			reloaded = true
			get_parent().reload_scene()
			
		$Path2D/PathFollow2D.offset += 9000 * delta
