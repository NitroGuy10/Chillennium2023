extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var num_players = 0
	for body in $Area2D.get_overlapping_bodies():
		if "Player" in body.name:
			num_players += 1
	
	if num_players >= 2:
		for body in $Area2D.get_overlapping_bodies():
			if body.get_parent().name == "Player":
				body.get_parent().get_node("Heart").visible = false
			elif body.get_parent().name == "Player2":
				body.get_parent().get_node("Heart").visible = true
		
		$Area2D/CollisionShape2D.disabled = true
		player_vars.exitOpen = true

