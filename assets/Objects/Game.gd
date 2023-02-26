extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var transitioning = false

var levels = [
#	preload("res://assets/Levels/Test_Level.tscn"),
	preload("res://assets/Levels/Level1.tscn"),
	preload("res://assets/Levels/Level2.tscn"),
	preload("res://assets/Levels/Level3.tscn"),
	preload("res://assets/Levels/Level4.tscn"),
	preload("res://assets/Levels/Level5.tscn"),
	preload("res://assets/Levels/Level6.tscn"),
	preload("res://assets/Levels/Level7.tscn"),
	preload("res://assets/Levels/Level8.tscn"),
	preload("res://assets/Levels/Level9.tscn"),
	preload("res://assets/Levels/TheEnd.tscn"),	
]

var transition = preload("res://assets/Objects/ScreenTransition.tscn")

var levelNum = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reload_scene():
	if levelNum == 9:
		$AudioStreamPlayer.stop()
	
	for i in range(0, $Level.get_child_count()):
		$Level.get_child(i).queue_free()
	
	var levelInstance = levels[levelNum].instance()

	$Level.add_child(levelInstance)

func _on_death(win = false):
	if not transitioning:
		if win:
			levelNum += 1
			$AudioStreamPlayerWin.play()
		
		transitioning = true
		player_vars.exitOpen = false
		add_child(transition.instance())
	
	
