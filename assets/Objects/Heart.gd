extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2(0, 0)
var noise
var noiseDistance = 0

onready var playerKB = get_parent().get_node("PlayerKinematicBody2D")


# Called when the node enters the scene tree for the first time.
func _ready():
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20.0
	noise.persistence = 0.8
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	noiseDistance += delta * 5
	$AnimatedSprite.position.x = noise.get_noise_2d(noiseDistance, 1.0) * 50
	$AnimatedSprite.position.y = noise.get_noise_2d(1.0, noiseDistance) * 50


func _physics_process(delta):
##	velocity *= 10 * delta
#
#	velocity += (playerKB.position - position) * delta * 0.2
#	position += velocity
	position = lerp(position, Vector2(playerKB.position.x, playerKB.position.y), 0.8 * delta)
	

