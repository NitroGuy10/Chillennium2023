extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var impartEmotion = false
export var emotion = "happy"
export var playSound = false

var pressed = false
var text
var textBounds = Vector2(0, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	text = get_parent().get_parent().get_node("WordPlatformText")
	
	# Set the CollisionShape2D sizes to that of the text
	var richTextLabel = get_parent().get_parent().get_node("WordPlatformText/RichTextLabel")
	richTextLabel.text = get_parent().get_parent().textString
	textBounds = richTextLabel.get_font("normal_font").get_string_size(richTextLabel.text) / 2
	$CollisionShape2D.shape.extents = textBounds  # Both collisionboxes use the same shape, so we only gotta change the shape once
	$CollisionShape2D.position = Vector2(textBounds.x, textBounds.y - 10)
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
	
