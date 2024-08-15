extends Node3D


# Called when the node enters the scene tree for the first time.

#Minimap objects are ONLY VISIBLE in mask layer 5. Mask layer 5 is DISABLED for visibility
# to the player camera.
func _ready():
	#set path of texture viewport to minimap camera
	pass # Replace with function body.
	$Body/Screen

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
