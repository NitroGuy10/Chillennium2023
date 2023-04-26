extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var transitioning = false
var start_button_pressed = false

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
	preload("res://assets/Levels/TheEnd.tscn")
]

var transition = preload("res://assets/Objects/ScreenTransition.tscn")
var chapterPopup = preload("res://assets/Objects/ChapterPopup.tscn")

var levelNum = -1
var titleScreen = true
var newLevel = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not start_button_pressed:
		if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("dash") || Input.is_action_just_pressed("dash_p2") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_up_p2"):
			_on_Button_pressed()

func reload_scene():
	if titleScreen:
		$AudioStreamPlayer.play()
		titleScreen = false
	if levelNum == 9:
		$AudioStreamPlayer.stop()
		$EmotionFlyup.visible = false
		for i in range(0, $Level.get_child_count()):
			$Level.get_child(i).queue_free()
		var levelInstance = levels[levelNum].instance()
		$Level.add_child(levelInstance)
	else:
		if newLevel:
			var chapterPopupInstance = chapterPopup.instance()
			chapterPopupInstance.get_node("AnimatedSprite").animation = "ch" + String(levelNum + 1)
			add_child(chapterPopupInstance)
			move_child(chapterPopupInstance, 1)
			$ChapterPopupTimer.start()
		
		for i in range(0, $Level.get_child_count()):
			$Level.get_child(i).queue_free()
		
		if not newLevel:
			var levelInstance = levels[levelNum].instance()
			$Level.add_child(levelInstance)
			$EmotionFlyup.visible = true
			
		else:
			newLevel = false
	
	
	

func _on_death(win = false, playSound = true, showTransition = true):
	if not transitioning:
		if win:
			levelNum += 1
			if playSound:
				$AudioStreamPlayerWin.play()
			newLevel = true
		
		transitioning = true
		$EmotionFlyup.visible = false
		player_vars.exitOpen = false
		var transitionInstance = transition.instance()
		transitionInstance.visible = showTransition
		add_child(transitionInstance)


#func _input(event):
#	if titleScreen and event is InputEventKey:
#		if event.pressed:
#			_on_death(true)

func _on_Button_pressed():
#	_on_death(true)
	if not start_button_pressed:
		start_button_pressed = true
		$Tutorial._on_Button_pressed()
		$Tutorial/Timer.start()


func _on_ChapterPopupTimer_timeout():
	var levelInstance = levels[levelNum].instance()
	$Level.add_child(levelInstance)
