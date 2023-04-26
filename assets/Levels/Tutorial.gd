extends Node2D


var tutorialStage = 0
var done = false
var first_input_buffer = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("dash") || Input.is_action_just_pressed("dash_p2") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_up_p2"):
		if not first_input_buffer:
			_on_Button_pressed()


func _on_Button_pressed():
	if not done:
		tutorialStage += 1
		if tutorialStage < 4:
			get_node("TutorialSlide" + String(tutorialStage)).entering = true
		else:
			for tutorialNum in range(tutorialStage - 1):
				get_node("TutorialSlide" + String(tutorialNum + 1)).get_node("ExitTimer").start()
			done = true
			$AudioStreamPlayer.play()
			get_parent()._on_death(true, false, false)


func _on_AudioStreamPlayer_finished():
	queue_free()


func _on_Timer_timeout():
	first_input_buffer = false
