extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var impartEmotion = false
var emotion = "happy"
var playSound = false
var textColor = Color(1, 1, 1)

var pressed = false
var text
var textBounds = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_parent().get_parent()
	
	impartEmotion = root.impartEmotion
	emotion = root.emotion
	playSound = root.playSound
	textColor = root.textColor
	
	text = get_parent().get_parent().get_node("WordPlatformText")
	
	# Set the CollisionShape2D sizes to that of the text
	var richTextLabel = root.get_node("WordPlatformText/RichTextLabel")
	richTextLabel.set("custom_colors/default_color", textColor)
#	richTextLabel.add_color_override("font_color", textColor)
	richTextLabel.text = root.textString
	textBounds = richTextLabel.get_font("normal_font").get_string_size(richTextLabel.text) / 2
	$CollisionShape2D.scale = textBounds
	$CollisionShape2D.position = Vector2(textBounds.x, textBounds.y - 10)
	get_parent().get_node("StaticBody2D/CollisionShape2D").scale = textBounds
	get_parent().get_node("StaticBody2D/CollisionShape2D").position = textBounds
	


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
				if impartEmotion:
					body.currentEmotion = emotion
				if playSound:
					get_parent().get_parent().get_node("AudioStreamPlayer").play(false)	
					get_parent().get_parent().get_node("AudioStreamPlayer")
					
					
			pressed = true
	
