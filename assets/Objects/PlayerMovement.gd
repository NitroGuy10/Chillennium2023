extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var jumpvelocity = 800.0
var walkspeed = 100.0
var horizontal_damping = 0.8
var gravityscale = 1600.0

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_input():
	if Input.is_action_pressed("ui_left"):
		velocity.x -= walkspeed
	elif Input.is_action_pressed("ui_right"):
		velocity.x += walkspeed
	velocity.x *= horizontal_damping
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = -jumpvelocity


func _physics_process(delta):
	velocity.y += gravityscale * delta
	get_input()
	move_and_slide(velocity, Vector2.UP)
