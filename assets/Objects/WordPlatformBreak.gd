extends Node2D

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



# Called when the node enters the scene tree for the first time.
func _ready():
	$BreakTimer.wait_time = timeToBreak
	$WordPlatformInteractable.textString = textString
	$WordPlatformInteractable/WordPlatformText/RichTextLabel.text = textString


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
