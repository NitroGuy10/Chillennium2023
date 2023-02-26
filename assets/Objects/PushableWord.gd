extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var textString = "Text!"



# Called when the node enters the scene tree for the first time.
func _ready():
	var richTextLabel = $RigidBody2D/WordPlatformText/RichTextLabel
	richTextLabel.text = textString
	
	var textBounds = richTextLabel.get_font("normal_font").get_string_size(richTextLabel.text) / 2
	$RigidBody2D/CollisionShape2D.scale = textBounds
	$RigidBody2D/CollisionShape2D.position = Vector2(textBounds.x, textBounds.y - 10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
