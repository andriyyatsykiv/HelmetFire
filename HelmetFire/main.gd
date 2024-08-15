extends Node
@onready var gameoptions = Configloader.load_game_options()
@onready var controloptions = Configloader.load_control_options()

#sets the scene to be generated as a target
@export var target_scene: PackedScene
@export var cockpit_scene: PackedScene
@export var bullseye_scene: PackedScene

#sets spawn timer timing interval
@onready var timer_time = float(gameoptions["TimerTime"])

#Sets north vector for reference
@onready var north = Vector3(0, 0, -1)

#initializes the dimensions of the area for spawning
@export var xmax = 100
@export var ymax = 10
@export var zmax = 100

#-------- TARGET SPAWNING / SETUP FUNCTION ----------------------------------------------
func startchallenge():
	
	#TURNS OUT THIS IS UNNECESSARY - I ACCIDENTALLY FIXED THE UNDERLYING ISSUE AT SOME POINT LMAO?
	#I think this caused me to double-instantiate the cockpit and I had a duplicate one
	#perched on top of the bullseye
	#Checks if cockpit already exists, if so, deletes that instance and replaces with new one.
	#Important for refreshing compasses and instruments to new challenge setting.
	#if has_node("Main/Cockpit"):
		#for child in $Cockpit.get_children():
			#child.queue_free()
		#$Cockpit.queue_free()

	#var Cockpit = cockpit_scene.instantiate()
	#add_child(Cockpit)
		
		#Randomly rotates the cockpit (around local y axis, by degrees in radians)
	if gameoptions["RandomizeOwnDirection"]:
		$Cockpit.rotate_y(randf_range(0, 2*PI))
	
		#If BULLSEYE used, spawns bullseye at world center
		#Randomizes location of cockpit around bullseye (doesn't move bullseye - moves AIRCRAFT)
	if gameoptions["UseBullseye"]:
		if gameoptions["BullseyeVisible"]:
			$bullseye/bullseyemesh.visible = true
		else:
			$bullseye/bullseyemesh.visible = false
		
		$Cockpit.position.x = randi() % (xmax) - (xmax/2)
		$Cockpit.position.y = randi() % (ymax) - (ymax/2)
		$Cockpit.position.z = randi() % (zmax) - (zmax/2)
		
	#Calculates and communicates the new heading of the aircraft
		#Gets the cockpit heading, and flattens it. This value is already normalized.
		var cockpitvector = $Cockpit.get_global_transform().basis.z
		cockpitvector.y = 0
		
		#Normalizes again to be safe, in case of future aircraft pitching up/down
		cockpitvector = cockpitvector.normalized()
		
		#It turns out, the z rotational basis vector for our aircraft actually points out the
		#rear of the aircraft. 
		#Here, we flip the signs of the z and x components to "flip" it 180 degrees.
		cockpitvector.x = cockpitvector.x * -1
		cockpitvector.z = cockpitvector.z * -1
		
		var cockpitnorthdeviation = north.dot(cockpitvector.normalized())
		var cockpitheading = rad_to_deg(acos(cockpitnorthdeviation))
			
		#If target is in eastern hemisphere (+x global), take pure deviation.
		#If facing west (-x global), take pure calculation as (360 deg - deviation)
		if cockpitvector.x < 0:
			cockpitheading = 360 - cockpitheading
		
		#COMPASS SETUP
		#Rotates compass needle to face proper direction.
		# Sets needle's LOCAL rotation to cockpits GLOBAL Z rotation.
		var needlevector = cockpitvector
		$Cockpit/AnalogHeadingIndicator/Needle.transform.basis.y = needlevector
		

		#DIGITAL HEADING SETUP
		var digitalheading = str(round(cockpitheading))
	
		#Splits the heading into an array of individual numbers
		digitalheading = digitalheading.split()
		if digitalheading.size() < 3:
			digitalheading.insert(0, "0")
		if digitalheading.size() < 2:
			digitalheading.insert(0, "0")
		
		
		var displayedheading = array_to_string(digitalheading)
		if displayedheading == "00":
			displayedheading = "360"
		
		$Cockpit/NumericalHeadingIndicator/Body/HeadingText.set_text(displayedheading)


		
	#Instantiates the target
	print("--- SPAWNING TARGET ---")
	var target = target_scene.instantiate()
		
	#randomizes position of target, and adds the target instance
	target.position.x = randi() % (2 * xmax) - xmax
	target.position.y = randi() % (2 * ymax) - ymax
	target.position.z = randi() % (2 * zmax) - zmax
	add_child(target)
	
#----------------------------------------------------------------------

# Called when the node enters the scene tree for the first time.
func _ready():
	startchallenge()
	randomize()
	$Timer.start(timer_time)


#Turns array into string, used for converting angle into formatted bearing (83 into 083)
func array_to_string(arr: Array) -> String:
	var s = ""
	for i in arr:
		s += String(i)
	return s


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):

	if event.is_action_pressed("spawn_override"):
		print("--- SPAWN OVERRIDE ---")
		startchallenge()

func _on_timer_timeout():
	startchallenge()
