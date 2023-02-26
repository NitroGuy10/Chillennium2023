extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

export var textString = "Text!"
export var loop = false

var richTextLabel
var wordPlatformInteractable
var shakingFrame = false
var shakingFlipflop = false



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	wordPlatformInteractable = $Path2D/PathFollow2D/WordPlatformInteractable
	richTextLabel = wordPlatformInteractable.get_node("WordPlatformText/RichTextLabel")
	
	wordPlatformInteractable.textString = textString
	wordPlatformInteractable.get_node("CollisionStuff/Area2D").set_text_collision()
	
	$Path2D/PathFollow2D.loop = loop
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wordPlatformInteractable.get_node("CollisionStuff/Area2D").pressed:
		richTextLabel.set("custom_colors/default_color", lerp(richTextLabel.get("custom_colors/default_color"), Color(0.3, 0.3, 0.3), 0.05))			
		if player_vars.currentEmotion == "distress":
			if shakingFrame:
				if shakingFlipflop:
					wordPlatformInteractable.get_node("WordPlatformText").position.x += rand_range(-5, 5)
					wordPlatformInteractable.get_node("WordPlatformText").position.y += rand_range(-5, 5)
				else:
					wordPlatformInteractable.get_node("WordPlatformText").position.x = 0
					wordPlatformInteractable.get_node("WordPlatformText").position.y = -10
				shakingFlipflop = !shakingFlipflop
			shakingFrame = !shakingFrame
	else:
		richTextLabel.set("custom_colors/default_color", lerp(richTextLabel.get("custom_colors/default_color"), Color(1, 1, 1), 0.05))

func _physics_process(delta):
	if wordPlatformInteractable.get_node("CollisionStuff/Area2D").pressed and player_vars.currentEmotion == "distress":
		$Path2D/PathFollow2D.offset += (100 * delta)
	else:
		$Path2D/PathFollow2D.offset -= (100 * delta)
