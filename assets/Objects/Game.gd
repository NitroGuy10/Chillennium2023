extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var levels = [
	preload("res://assets/Levels/Level3.tscn")
]

var levelNum = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_death():
	print("Dead")
	
	for i in range(0, $Level.get_child_count()):
		$Level.get_child(i).queue_free()
	
	var levelInstance = levels[levelNum].instance()
	
	print(levelInstance.name)
	$Level.add_child(levelInstance)
