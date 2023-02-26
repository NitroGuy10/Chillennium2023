extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = player_vars.exitOpen

func _physics_process(delta):
	$Area2D/CollisionShape2D.disabled = not player_vars.exitOpen
	
	for body in $Area2D.get_overlapping_bodies():
		if "Player" in body.name:
			get_parent().get_parent().get_parent().levelNum += 1
			get_parent().get_parent().get_parent()._on_death()
