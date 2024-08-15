extends StaticBody3D
@onready var gameoptions = Configloader.load_game_options()
@onready var north = Vector3(0, 0, -1)
@onready var timer_time = gameoptions["TimerTime"]

func getbullseye():
	#GETTING THE BEARING
		#Gets the bearing, and flattens it
		var cockpitflat = $Cockpit.global_position
		cockpitflat.y = 0
		#Compares global position vector to north to make dot product
		var cockpit_bullseye_north_deviation = north.dot(cockpitflat.normalized())
		var bullseye_cockpit_bearing = rad_to_deg(acos(cockpit_bullseye_north_deviation))
			
		#If target is in eastern hemisphere (+x global), take pure deviation.
		#If facing west (-x global), take pure calculation as (360 deg - deviation)
		var cockpitposition = ($Cockpit.global_position).normalized()
		if cockpitposition.x < 0:
			bullseye_cockpit_bearing = 360 - bullseye_cockpit_bearing

		#GETTING THE DISTANCE
		#Distance needs to be flattened to be ground range, not slant range. 
		#Plan - Obtain position of target and reference point as Vector3, zero the vertical aspect, and compare
		#the two new positions via distance_to
		var bullseyeflat = get_node("../bullseyemarker").global_position
		bullseyeflat.y = 0
		var bullseye_cockpit_distance = round(cockpitflat.distance_to(bullseyeflat))
		
		#ASSEMBLES INTO INDICATED-FORMAT TEXT
			#Rounds the bearing and sets it as string
		bullseye_cockpit_bearing = str(round(bullseye_cockpit_bearing))
		
			#Splits the bearing into an array of individual numbers
		bullseye_cockpit_bearing = bullseye_cockpit_bearing.split()
		
			#if bearing is two digits (ie "63") inserts 0 at start to make "063"
		if bullseye_cockpit_bearing.size() < 3:
			bullseye_cockpit_bearing.insert(0, "0")
			#if bearing is only one digit, inserts a second zero at the start (ie. 6 becomes 006)
		if bullseye_cockpit_bearing.size() < 2:
			bullseye_cockpit_bearing.insert(0, "0")
			
		#Reassembles as string
		var bullseye_bearing_final_text = ""
		for number in bullseye_cockpit_bearing:
			bullseye_bearing_final_text = bullseye_bearing_final_text + number
		
		#Inserts into format
		var bullseyeformat = "%s / %s"
		var displayedbullseye = bullseyeformat % [bullseye_bearing_final_text, bullseye_cockpit_distance]
		$BullseyeTextIndicator/Body/BullseyeText.set_text(displayedbullseye)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(timer_time)
	if gameoptions["NumericalHeadingIndicator"]:
		$NumericalHeadingIndicator.visible = true
	else:
		$NumericalHeadingIndicator.visible = false
		
	if gameoptions["AnalogHeadingIndicator"]:
		$AnalogHeadingIndicator.visible = true
	else:
		$AnalogHeadingIndicator.visible = false
		
	if gameoptions["TextBullseye"]:
		$BullseyeTextIndicator.visible = true
		getbullseye()
	else:
		$BullseyeTextIndicator.visible = false
	
	if gameoptions["MapBullseye"]:
		$Minimap.visible = true
	else:
		$Minimap.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	getbullseye()
