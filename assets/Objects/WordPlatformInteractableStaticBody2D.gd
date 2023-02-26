extends Area2D
onready var player_vars = get_node("/root/PlayerVariables")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



var textColor = Color(1, 1, 1)
var TEXT_COLORS = {
	"none": Color(1, 1, 1),
	"happiness": Color(1, 1, 0),
	"fear": Color(0.72, 0, 1),
	"anger": Color(1, 0, 0),
	"disgust": Color(0, 1, 0),
	"contempt": Color(0, 0, 0),
	"guilt": Color(0, 1, 1),
	"distress": Color(0.5, 0.5, 0.5),
	"peace": Color(0, 0, 0.5),
	"hope": Color(1, 0.5, 0)	
}

var pressed = false
var nearby = false
var text
var textBounds = Vector2(0, 0)
var root
var richTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_parent().get_parent()
	
#	textColor = root.textColor
	textColor = TEXT_COLORS[root.get_emotion()]
	
	text = root.get_node("WordPlatformText")
	
	# Set the CollisionShape2D sizes to that of the text
	richTextLabel = root.get_node("WordPlatformText/RichTextLabel")
	if root.showImpartColor:
		richTextLabel.set("custom_colors/default_color", textColor)
#	richTextLabel.add_color_override("font_color", textColor)
	set_text_collision()
	
	
func set_text_collision():
	richTextLabel.text = root.textString
	textBounds = richTextLabel.get_font("normal_font").get_string_size(richTextLabel.text) / 2
	$CollisionShape2D.scale.x = textBounds.x
	$CollisionShape2D.scale.y = 5
	$CollisionShape2D.position = Vector2(textBounds.x, textBounds.y - 20)
	get_parent().get_node("StaticBody2D/CollisionShape2D").scale.x = textBounds.x
	get_parent().get_node("StaticBody2D/CollisionShape2D").scale.y = 8
	get_parent().get_node("StaticBody2D/CollisionShape2D").position.x = textBounds.x
	get_parent().get_node("StaticBody2D/CollisionShape2D").position.y = -12
	get_parent().get_node("VisibleArea/CollisionShape2D").position.x = textBounds.x
	get_parent().get_node("VisibleArea/CollisionShape2D").position.y = -12
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if root.onlyVisibleInContempt:
		root.visible = player_vars.currentEmotion == "contempt"
	else:
		root.visible = player_vars.currentEmotion != "contempt" or nearby
	
	if pressed:
		if root.fallThoughInGuilt and player_vars.currentEmotion == "guilt":
			richTextLabel.set("custom_colors/default_color", Color(0, 1, 1))
		text.position.y = lerp(text.position.y, 0, 0.2)
	else:
		if root.fallThoughInGuilt and player_vars.currentEmotion == "guilt":
			richTextLabel.set("custom_colors/default_color", Color(1, 1, 1))
		text.position.y = lerp(text.position.y, -10, 0.2)

func _physics_process(delta):
	if root.onlyVisibleInContempt:
		set_collision_layer_bit(7, player_vars.currentEmotion == "contempt")
		set_collision_mask_bit(7, player_vars.currentEmotion == "contempt")
		get_parent().get_node("VisibleArea").set_collision_layer_bit(7, player_vars.currentEmotion == "contempt")
		get_parent().get_node("VisibleArea").set_collision_mask_bit(7, player_vars.currentEmotion == "contempt")
		get_parent().get_node("StaticBody2D").set_collision_layer_bit(7, player_vars.currentEmotion == "contempt")
		get_parent().get_node("StaticBody2D").set_collision_mask_bit(7, player_vars.currentEmotion == "contempt")
	
	if root.fallThoughInGuilt:
		get_parent().get_node("StaticBody2D").set_collision_layer_bit(7, player_vars.currentEmotion != "guilt")
		get_parent().get_node("StaticBody2D").set_collision_mask_bit(7, player_vars.currentEmotion != "guilt")

	
	
	var previous_pressed_status = pressed
	pressed = false
	for body in get_overlapping_bodies():
		if "Player" in body.name:
			if previous_pressed_status == false:
				if root.enableEmotion:
					player_vars.currentEmotion = root.get_emotion()
					get_parent().get_parent().get_node("AudioStreamPlayer").play()
				else:
					get_parent().get_parent().get_node("AudioStreamPlayerNormal").play()					
				if root.giveTutorialText:
					body.get_parent().get_node("TutorialText/RichTextLabel").text = root.tutorialText
					
			pressed = true
	
	nearby = false
	for body in get_parent().get_node("VisibleArea").get_overlapping_bodies():
		if "Player" in body.name:
			nearby = true
			break
			
	
