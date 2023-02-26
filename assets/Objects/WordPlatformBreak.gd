extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var timeToBreak = 1
export var textString = "Text!"

var breaking = false
var falling = false

var breakingFlipflop = false
var breakingFrame = false
var yVelocity = 0
var richTextLabel



# Called when the node enters the scene tree for the first time.
func _ready():
	richTextLabel = $WordPlatformInteractable/WordPlatformText/RichTextLabel
	
	$BreakTimer.wait_time = timeToBreak
	$WordPlatformInteractable.textString = textString
	richTextLabel.text = textString


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_vars.currentEmotion == "disgust":
		richTextLabel.set("custom_colors/default_color", lerp(richTextLabel.get("custom_colors/default_color"), Color(0, 1, 0, 1), 0.05))
	else:
		richTextLabel.set("custom_colors/default_color", lerp(richTextLabel.get("custom_colors/default_color"), Color(0, 1, 0, 0), 0.05))

	
	if breaking:
		if breakingFrame:
			if breakingFlipflop:
				$WordPlatformInteractable/WordPlatformText.position.x += rand_range(-10, 10)
				$WordPlatformInteractable/WordPlatformText.position.y += rand_range(-10, 10)
			else:
				$WordPlatformInteractable/WordPlatformText.position.x = 0
				$WordPlatformInteractable/WordPlatformText.position.y = -10
			breakingFlipflop = !breakingFlipflop
		breakingFrame = !breakingFrame


func _physics_process(delta):
	$WordPlatformInteractable/CollisionStuff/Area2D.set_collision_layer_bit(7, player_vars.currentEmotion == "disgust")
	$WordPlatformInteractable/CollisionStuff/Area2D.set_collision_mask_bit(7, player_vars.currentEmotion == "disgust")
	$WordPlatformInteractable/CollisionStuff/StaticBody2D.set_collision_layer_bit(7, player_vars.currentEmotion == "disgust")
	$WordPlatformInteractable/CollisionStuff/StaticBody2D.set_collision_mask_bit(7, player_vars.currentEmotion == "disgust")
	
	
	if !breaking and $WordPlatformInteractable/CollisionStuff/Area2D.pressed:
		breaking = true
		$BreakTimer.start()
	
	if falling:
		yVelocity += 100 * delta
		position.y += yVelocity


func _on_BreakTimer_timeout():
#	visible = false
	$WordPlatformInteractable/CollisionStuff/StaticBody2D/CollisionShape2D.disabled = true
	$FallTimer.start()
	falling = true


func _on_FallTimer_timeout():
	queue_free()
