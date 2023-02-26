extends AnimatedSprite
onready var player_vars = get_node("/root/PlayerVariables")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var initialPos
var offsetPos = Vector2(0, 0)

onready var player1KB = get_parent().get_node("Player/PlayerKinematicBody2D")
onready var player2KB = get_parent().get_node("Player2/PlayerKinematicBody2D")


# Called when the node enters the scene tree for the first time.
func _ready():
	initialPos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	visible = player_vars.currentEmotion != "contempt"
	
	offsetPos = (player1KB.global_position + player2KB.global_position) / 2.0
	offsetPos.x -= 640
	offsetPos.y -= 360
	offsetPos *= 0.05
	position = lerp(position, initialPos + offsetPos, 5 * delta)
