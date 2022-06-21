extends Area2D

signal outOfCamera

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_outCameraVertical_body_entered(body):
	if(body.is_in_group("Player")):
		emit_signal("outOfCamera")
	pass # Replace with function body.
