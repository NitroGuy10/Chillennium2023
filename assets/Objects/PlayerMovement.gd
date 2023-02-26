extends KinematicBody2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isPlayer2 = false
var otherPlayer

var jumpvelocity = 600.0
var dashvelocity = 500.0
var dashHorizScalar = 1.5
var happyJumpVelocity = 900.0
var walkspeed = 100.0
var horizontal_damping = 0.8
var gravityscale = 1600.0
var canDash = false
var canDoubleJump = false

var velocity = Vector2()

var EMOTION_ANIMATIONS = {
	"none": "none",
	"happiness": "happy",
	"fear": "sad",
	"anger": "angry",
	"disgust": "disgust",
	"contempt": "angry",
	"guilt": "guilt",
	"distress": "distress",
	"peace": "none",
	"hope": "happy"
}


# Called when the node enters the scene tree for the first time.
func _ready():
	isPlayer2 = get_parent().isPlayer2



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HappyParticles.emitting = player_vars.currentEmotion == "happiness"
	$AngerParticles.emitting = player_vars.currentEmotion == "anger"
	$DisgustParticles.emitting = player_vars.currentEmotion == "disgust"
	$ContemptParticles.emitting = player_vars.currentEmotion == "contempt"
	$GuiltParticles.emitting = player_vars.currentEmotion == "guilt"
	$DistressParticles.emitting = player_vars.currentEmotion == "distress"
	$PeaceParticles.emitting = player_vars.currentEmotion == "peace"
	$HopeParticles.emitting = player_vars.currentEmotion == "hope" and canDoubleJump
	$DashParticles.emitting = player_vars.currentEmotion == "fear" and canDash
	
	if velocity.x > 0:
		$AnimatedSprite.scale.x = -0.5
		if player_vars.currentEmotion == "happiness" || player_vars.currentEmotion == "hope":
			$AnimatedSprite.position.x = 117
		else:
			$AnimatedSprite.position.x = 56
	else:
		$AnimatedSprite.scale.x = 0.5
		if player_vars.currentEmotion == "happiness" || player_vars.currentEmotion == "hope":
			$AnimatedSprite.position.x = -122		
		else:		
			$AnimatedSprite.position.x = -64
	
	if abs(velocity.x) > 10:
		$AnimatedSprite.animation = "walk_" + EMOTION_ANIMATIONS[player_vars.currentEmotion]
	else:
		$AnimatedSprite.animation = "stand_" + EMOTION_ANIMATIONS[player_vars.currentEmotion]
		
	
	
	

func is_pressed_for_me(key_name: String):
	if isPlayer2:
		return Input.is_action_pressed(key_name + "_p2")
	else:
		return Input.is_action_pressed(key_name)

func is_just_pressed_for_me(key_name: String):
	if isPlayer2:
		return Input.is_action_just_pressed(key_name + "_p2")
	else:
		return Input.is_action_just_pressed(key_name)

func actually_is_on_floor():
	return is_on_floor() || $PushableWordRayCast.is_colliding() || $PushableWordRayCast2.is_colliding()


func _physics_process(delta):

	if is_pressed_for_me("ui_left"):
		velocity.x -= walkspeed
	elif is_pressed_for_me("ui_right"):
		velocity.x += walkspeed
	velocity.x *= horizontal_damping
	
	# If standing on PushableWord
	if $PushableWordRayCast.is_colliding() || $PushableWordRayCast2.is_colliding(): 
		velocity.y = min(velocity.y, 0)
	
	# If hitting head on ceiling
	if $CeilingRayCast.is_colliding() || $CeilingRayCast2.is_colliding():
		velocity.y = max(velocity.y, 0)
	
	if actually_is_on_floor():
		if player_vars.currentEmotion == "fear":
			canDash = true
		if player_vars.currentEmotion == "hope":
			canDoubleJump = true
		if is_pressed_for_me("ui_up"):
			get_parent().get_node("JumpSFX").play()			
			if player_vars.currentEmotion == "happiness":
				velocity.y = -happyJumpVelocity
			elif player_vars.currentEmotion == "peace":
				velocity.y = -jumpvelocity * 5
			else:
				velocity.y = -jumpvelocity
				
		else:
			velocity.y = 0
	else:
		velocity.y += gravityscale * delta
		if canDash and player_vars.currentEmotion == "fear" and is_pressed_for_me("dash"):
			canDash = false
			if is_pressed_for_me("ui_up"):
				velocity.y = -dashvelocity
				get_parent().get_node("JumpSFX").play()
			elif is_pressed_for_me("ui_down"):
				velocity.y = dashvelocity
				get_parent().get_node("JumpSFX").play()				
			if is_pressed_for_me("ui_left"):
				velocity.x = -dashvelocity * dashHorizScalar
				get_parent().get_node("JumpSFX").play()				
			elif is_pressed_for_me("ui_right"):
				velocity.x = dashvelocity * dashHorizScalar
				get_parent().get_node("JumpSFX").play()				
			else:
				canDash = true
		elif canDoubleJump and player_vars.currentEmotion == "hope" and is_just_pressed_for_me("ui_up"):
			canDoubleJump = false
			velocity.y = -jumpvelocity
			get_parent().get_node("JumpSFX").play()
			
			
	
	if player_vars.currentEmotion == "peace":
		velocity *= 0.7
	
	move_and_slide(velocity, Vector2.UP)
