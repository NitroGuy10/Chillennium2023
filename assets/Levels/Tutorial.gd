extends Node2D


var tutorialStage = 1
var done = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



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
