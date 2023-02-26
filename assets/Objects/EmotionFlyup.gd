extends Node2D
onready var player_vars = get_node("/root/PlayerVariables")


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var EMOTIONS = {
	"none": { "color": Color(1, 1, 1), "text": "" },
	"happiness": { "color": Color(1, 1, 0), "text": "Joy" },
	"fear": { "color": Color(0.72, 0, 1), "text": "Fear" },
	"anger": { "color": Color(1, 0, 0), "text": "Anger" },
	"disgust": { "color": Color(0, 1, 0), "text": "Disgust" },
	"contempt": { "color": Color(0, 0, 0), "text": "Contempt" },
	"guilt": { "color": Color(0, 1, 1), "text": "Guilt" },
	"distress": { "color": Color(0.5, 0.5, 0.5), "text": "Distress" },
	"peace": { "color": Color(0, 0, 0.5), "text": "Peace" },
	"hope": { "color": Color(1, 0.5, 0), "text": "Hope" }
}

var lastEmotion = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_vars.currentEmotion != lastEmotion:
		var emotion = EMOTIONS[player_vars.currentEmotion]
		$WordPlatformText/RichTextLabel.bbcode_text = "[center]" + emotion.text + "[/center]"
		
		
