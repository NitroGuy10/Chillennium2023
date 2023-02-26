extends Area2D
onready var player_vars = get_node("/root/PlayerVariables")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



var playSound = false
var textColor = Color(1, 1, 1)
var TEXT_COLORS = {
	"none": Color(1, 1, 1),	
	"happiness": Color(1, 1, 0),
	"fear": Color(0.72, 0, 1),
	"anger": Color(1, 0, 0)	,
	"disgust": Color(0, 1, 0)	
}

var pressed = false
var text
var textBounds = Vector2(0, 0)
var root


# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent().get_parent()
	
	playSound = root.playSound
#	textColor = root.textColor
	textColor = TEXT_COLORS[root.get_emotion()]
	
	text = root.get_node("WordPlatformText")
	
	# Set the CollisionShape2D sizes to that of the text
	var richTextLabel = root.get_node("WordPlatformText/RichTextLabel")
	richTextLabel.set("custom_colors/default_color", textColor)
#	richTextLabel.add_color_override("font_color", textColor)
	richTextLabel.text = root.textString
	textBounds = richTextLabel.get_font("normal_font").get_string_size(richTextLabel.text) / 2
	$CollisionShape2D.scale.x = textBounds.x
	$CollisionShape2D.scale.y = 20
	$CollisionShape2D.position = Vector2(textBounds.x, textBounds.y - 30)
	get_parent().get_node("StaticBody2D/CollisionShape2D").scale.x = textBounds.x
	get_parent().get_node("StaticBody2D/CollisionShape2D").scale.y = 20
	get_parent().get_node("StaticBody2D/CollisionShape2D").position.x = textBounds.x
	get_parent().get_node("StaticBody2D/CollisionShape2D").position.y = 15
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if pressed:
		text.position.y = lerp(text.position.y, 0, 0.2)
	else:
		text.position.y = lerp(text.position.y, -10, 0.2)

func _physics_process(delta):
	var previous_pressed_status = pressed
	pressed = false
	for body in get_overlapping_bodies():
		if "Player" in body.name:
			if previous_pressed_status == false:
				if root.enableEmotion:
					player_vars.currentEmotion = root.get_emotion()
				if playSound:
					get_parent().get_parent().get_node("AudioStreamPlayer").play(false)	
					get_parent().get_parent().get_node("AudioStreamPlayer")
					
					
			pressed = true
	
