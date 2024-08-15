extends CharacterBody3D
@onready var gameoptions = Configloader.load_game_options()

@onready var north = Vector3(0, 0, -1)
@onready var hitradius = float(gameoptions["AllowableDirectionalError"])

#Sets up sound effects
@onready var missed_sound = $missed
@onready var correct_sound = $correct

#TEXT TO SPEECH SETUP AND PHRASEOLOGY
#https://docs.godotengine.org/en/stable/tutorials/audio/text_to_speech.html
#Gets list of voices
@onready var voices = DisplayServer.tts_get_voices_for_language("en")
#Selects first voice in array of voices
@onready var voice_id = voices[0]



func playcall():
	#GETTING THE BEARING
		#Gets the bearing, and flattens it
		var targetflat = $targetmesh.global_position
		targetflat.y = 0
		#Compares global position vector to north to make dot product
		var targetnorthdeviation = north.dot(targetflat.normalized())
		var bearing = rad_to_deg(acos(targetnorthdeviation))
			
		#If target is in eastern hemisphere (+x global), take pure deviation.
		#If facing west (-x global), take pure calculation as (360 deg - deviation)
		var targetposition = ($targetmesh.global_position).normalized()
		if targetposition.x < 0:
			bearing = 360 - bearing 

		#GETTING THE DISTANCE
		#GETS THE DISTANCE FROM BULLSEYE NODE SINCE THIS IS AT WORLD ORIGIN ANYWAYS
		var reference_point_flat = get_node("../bullseyemarker").global_position
		reference_point_flat.y = 0
		var distance = round(reference_point_flat.distance_to(targetflat))
		#TODO Distance needs to be flattened to be ground range, not slant range. 
		#Plan - Obtain position of target and reference point as Vector3, zero the vertical aspect, and compare
		#the two new positions via distance_to

	#PLAYING THE TTS
	
		#Sets up BRA call format
		var callformat = ""
		if gameoptions["UseBullseye"]:
			callformat = "Bullseye %s for %s, at %s thousand, %s"
		else:
			callformat = "BRA %s for %s, at %s thousand, %s"
			
		var aspect_varieties = ["hot", "cold"]
		var aspect = aspect_varieties[randi() % aspect_varieties.size()-1]
		
		var altitude = str(randi_range(5, 30))
		
		#Rounds the bearing and sets it as string
		var bearing_verbal_prep = str(round(bearing))
	
		#Splits the bearing into an array of individual numbers
		bearing_verbal_prep = bearing_verbal_prep.split()
		
		#if bearing is two digits (ie "63") inserts 0 at start to make "063"
		if bearing_verbal_prep.size() < 3:
			bearing_verbal_prep.insert(0, "0")
		if bearing_verbal_prep.size() < 2:
			bearing_verbal_prep.insert(0, "0")
			
		#Reassembles as string with spaces in between each number
		var bearing_verbal = ""
		for number in bearing_verbal_prep:
			bearing_verbal = bearing_verbal + number
			bearing_verbal = bearing_verbal + " "
		
		#Refers back to the formatted text, and inputs the values into the placeholder %s signs
		var call = callformat % [bearing_verbal, distance, altitude, aspect]
		DisplayServer.tts_speak(call, voice_id)
		print(call)
		
		#Sets the subtitle text to the bracall string, if subtitles enabled
		if gameoptions["Subtitles"]:
			$/root/Main/Cockpit/Player/HUD/MarginContainer/SubtitleLabel.set_text(call)
		
func hitcheck():
	#HIT CHECKING SCRIPT
	# ----- Directions here MUST be local to the player, because we are checking if player is ----
	# ----- looking in the right direction at the target relative to the player. -----------------
	
	#COMPARES THE "CAMERA" VECTOR (ROTATIONAL TRANSFORM BASIS Z - https://docs.godotengine.org/en/stable/tutorials/3d/using_transforms.html)
	# TO THE VECTOR OF TARGETVECTOR MINUS CAMERA VECTOR (GIVES US A RESULT VECTOR FROM PLAYER TO TARGET)
	# WE THEN NORMALIZE THE PLAYER VECTOR (BASIS VECTORS ARE ALREADY NORMALIZED) THAT WAY WE CAN COMPARE 
	# THE INDIVIDUAL VALUES OF THE TWO WITH DOT PRODUCTS.

	#Finds the camera in tree
	#Gets the Z basis transform vector 
	#(the one that points where the camera is looking) of the camera and normalizes it.
	#This figures out where the player is looking. Basis vectors are already normalized.
		var lookdirection = get_node("../Cockpit/Player/Camera").get_global_transform().basis.z

	#Now, we get the target vector from origin minus player vector from origin, to get the player to target vector.
	#We normalize them since distance is irrelevant.
	#This is the direction from player to target.
		var targetdirection = (get_node("../Cockpit/Player").global_position - $targetmesh.global_position).normalized()

	#Gets the dot product of the two directions to compare them. 
	#https://docs.godotengine.org/en/stable/tutorials/math/vector_math.html
		var directioncomparison = lookdirection.dot(targetdirection)
	
	#Gets the angle, in radians, between the two directions.
	#This is the deviation from player-target vector to Camera face vector via arc cos of dot product
		var deviation = rad_to_deg(acos(directioncomparison))
		print("Deviation of cursor from target")
		print(deviation)
		
		if deviation < hitradius:
			correct_sound.play()
			await get_tree().create_timer(.2).timeout
			queue_free()
		else:
			missed_sound.play()
			

func _ready():
	if gameoptions["TargetsVisible"]:
		$targetmesh.visible = true
	else:
		$targetmesh.visible = false
	playcall()

func _input(event):
	#The big boy hit checking script
	#COMPARES THE "CAMERA" VECTOR (ROTATIONAL TRANSFORM BASIS Z - https://docs.godotengine.org/en/stable/tutorials/3d/using_transforms.html)
	# TO THE VECTOR OF TARGETVECTOR MINUS CAMERA VECTOR (GIVES US A RESULT VECTOR FROM PLAYER TO TARGET)
	# WE THEN NORMALIZE THE PLAYER VECTOR (BASIS VECTORS ARE ALREADY NORMALIZED) THAT WAY WE CAN COMPARE 
	# THE INDIVIDUAL VALUES OF THE TWO WITH DOT PRODUCTS.
	# COMPARES THE VALUES WITH ALL TARGETS IN THE TARGET GROUP

	# On click, we can call all the targets in the targets group to do a function for the hit check.
	# https://docs.godotengine.org/en/stable/tutorials/scripting/groups.html
	if event.is_action_pressed("select"):
		print("executing hitcheck")
		hitcheck()

	if event.is_action_pressed("playcall"):
		playcall()
