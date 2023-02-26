extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var textString = "Text!"

var pushed = false
var pushable = false
var richTextLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	richTextLabel = $RigidBody2D/WordPlatformText/RichTextLabel
	richTextLabel.text = textString
	
	var textBounds = richTextLabel.get_font("normal_font").get_string_size(richTextLabel.text) / 2
	$RigidBody2D/CollisionShape2D.scale = textBounds
	$RigidBody2D/CollisionShape2D.position = Vector2(textBounds.x, textBounds.y - 10)
	$RigidBody2D/Area2D/CollisionShape2D.scale = textBounds * 1.1
	$RigidBody2D/Area2D/CollisionShape2D.position = Vector2(textBounds.x, textBounds.y - 10)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = player_vars.currentEmotion != "contempt"
	
	if pushable:
		richTextLabel.set("custom_colors/default_color", lerp(richTextLabel.get("custom_colors/default_color"), Color(1, 0, 0), 0.05))
	else:
		if pushed:
			richTextLabel.set("custom_colors/default_color", lerp(richTextLabel.get("custom_colors/default_color"), Color(1, 0.3, 0.3), 0.05))			
		else:
			richTextLabel.set("custom_colors/default_color", lerp(richTextLabel.get("custom_colors/default_color"), Color(1, 1, 1), 0.05))


func _physics_process(delta):
	pushable = player_vars.currentEmotion == "anger"
	pushed = false
	for body in $RigidBody2D/Area2D.get_overlapping_bodies():
		if "Player" in body.name:
			pushed = true
	
	$RigidBody2D.set_collision_layer_bit(7, pushable)
	$RigidBody2D.set_collision_mask_bit(7, pushable)
	$RigidBody2D.set_collision_layer_bit(8, pushable)
	$RigidBody2D.set_collision_mask_bit(8, pushable)
		
	
