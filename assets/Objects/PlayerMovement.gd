extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isPlayer2 = false

var jumpvelocity = 800.0
var walkspeed = 100.0
var horizontal_damping = 0.8
var gravityscale = 1600.0

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	isPlayer2 = get_parent().isPlayer2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func is_pressed_for_me(key_name: String):
	if isPlayer2:
		return Input.is_action_pressed(key_name + "_p2")
	else:
		return Input.is_action_pressed(key_name)

func _physics_process(delta):
	if is_pressed_for_me("ui_left"):
		velocity.x -= walkspeed
	elif is_pressed_for_me("ui_right"):
		velocity.x += walkspeed
	velocity.x *= horizontal_damping
	
	
	
	if is_on_floor():
		if is_pressed_for_me("ui_up"):
			velocity.y = -jumpvelocity
		else:
			velocity.y = 0
	else:
		velocity.y += gravityscale * delta

	move_and_slide(velocity, Vector2.UP)
