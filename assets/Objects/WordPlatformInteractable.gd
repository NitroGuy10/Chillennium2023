extends Node2D


export var textString = "Text!"

export var onlyVisibleInContempt = false
export var fallThoughInGuilt = false
export var showImpartColor = true
export var giveTutorialText = false
export var tutorialText = "WASD to move"


export var enableEmotion = false
export var impartHappiness = false
export var impartFear = false
export var impartAnger = false
export var impartDisgust = false
export var impartContempt = false
export var impartGuilt = false
export var impartDistress = false
export var impartPeace = false
export var impartHope = false



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
	elif impartContempt:
		return "contempt"
	elif impartGuilt:
		return "guilt"
	elif impartDistress:
		return "distress"
	elif impartPeace:
		return "peace"
	elif impartHope:
		return "hope"
	assert(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
