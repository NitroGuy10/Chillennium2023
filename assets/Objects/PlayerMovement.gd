extends KinematicBody2D
onready var player_vars = get_node("/root/PlayerVariables")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isPlayer2 = false
var otherPlayer

var jumpvelocity = 800.0
var dashvelocity = 1000.0
var dashHorizScalar = 2.5
var happyJumpVelocity = 1200.0
var walkspeed = 100.0
var horizontal_damping = 0.8
var gravityscale = 1600.0
var canDash = false

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	isPlayer2 = get_parent().isPlayer2



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HappyParticles.emitting = player_vars.currentEmotion == "happiness"
	$AngerParticles.emitting = player_vars.currentEmotion == "anger"
	$DisgustParticles.emitting = player_vars.currentEmotion == "disgust"	
	$DashParticles.emitting = player_vars.currentEmotion == "fear" and canDash
		

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
		if is_pressed_for_me("ui_up"):
			if player_vars.currentEmotion == "happiness":
				velocity.y = -happyJumpVelocity
			else:
				velocity.y = -jumpvelocity
		else:
			velocity.y = 0
	else:
		velocity.y += gravityscale * delta
		if canDash and is_pressed_for_me("dash"):
			canDash = false
			if is_pressed_for_me("ui_up"):
				velocity.y = -dashvelocity
			elif is_pressed_for_me("ui_down"):
				velocity.y = dashvelocity
			if is_pressed_for_me("ui_left"):
				velocity.x = -dashvelocity * dashHorizScalar
			elif is_pressed_for_me("ui_right"):
				velocity.x = dashvelocity * dashHorizScalar
			else:
				canDash = true
			
	
	move_and_slide(velocity, Vector2.UP)
