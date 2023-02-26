extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

signal death




# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	player_vars.currentEmotion = "none"
	connect("death", get_parent().get_parent(), "_on_death")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reset"):
		emit_signal("death")


