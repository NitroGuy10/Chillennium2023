extends Node2D


export var textString = "Text!"

export var enableEmotion = false
export var impartHappiness = false
export var impartFear = false
export var impartAnger = false
export var impartDisgust = false


export var playSound = false
#export var textColor = Color(1, 1, 1)


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_emotion():
	if !enableEmotion:
		return "none"
	if impartHappiness:
		return "happiness"
	elif impartFear:
		return "fear"
	elif impartAnger:
		return "anger"
	elif impartDisgust:
		return "disgust"
	assert(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
