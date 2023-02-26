extends Area2D

signal death

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("death", get_parent(), "_on_death")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if "Player" in body.name:
			emit_signal("death")
