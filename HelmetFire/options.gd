extends Control
#Remember, when changing a setting here -
#Check that default value is set in configloader
#Check signal is connected to button
#Check the CORRECT SETTING is being loaded into the button WITH CORRECT TARGET BUTTON NAME
#Check spelling
#Check that the appropriate feature is checking for the setting
#------- LOADS SETTINGS
@onready var gameoptions = Configloader.load_game_options()
@onready var controloptions = Configloader.load_control_options()

func populate_settings():
	#Reloading them here allows "reset to defaults" to work, otherwise the defaults button
	#references the already loaded and saved "old" game options
	gameoptions = Configloader.load_game_options()
	controloptions = Configloader.load_control_options()
	
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/TargetsVisible.set_pressed(gameoptions["TargetsVisible"])
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/Subtitles.set_pressed(gameoptions["Subtitles"])
	
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/RandomizeOwnDirection.set_pressed(gameoptions["RandomizeOwnDirection"])
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/NumericalHeadingIndicator.set_pressed(gameoptions["NumericalHeadingIndicator"])
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/AnalogHeadingIndicator.set_pressed(gameoptions["AnalogHeadingIndicator"])
	
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/UseBullseye.set_pressed(gameoptions["UseBullseye"])
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/TextBullseye.set_pressed(gameoptions["TextBullseye"])
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/MapBullseye.set_pressed(gameoptions["MapBullseye"])
	$MarginContainer/VBoxContainer/HBoxContainer/GameOptions/BullseyeVisible.set_pressed(gameoptions["BullseyeVisible"])
	
	$MarginContainer/VBoxContainer/HBoxContainer/ControlOptions/TimerTime.set_text(str(gameoptions["TimerTime"]))
	$MarginContainer/VBoxContainer/HBoxContainer/ControlOptions/AllowableDirectionalError.set_text(str(gameoptions["AllowableDirectionalError"]))
	$MarginContainer/VBoxContainer/HBoxContainer/ControlOptions/MouseSensitivity.set_text(str(controloptions["MouseSensitivity"]))


# Called when the node enters the scene tree for the first time.
func _ready():
	populate_settings()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#--------- SETTINGS CHANGES PROCESSING ------------------------------------------------

func _on_targets_visible_toggled(toggled_on):
	Configloader.save_game_options("TargetsVisible", toggled_on)

func _on_subtitles_toggled(toggled_on):
	Configloader.save_game_options("Subtitles", toggled_on)

func _on_randomize_own_direction_toggled(toggled_on):
	Configloader.save_game_options("RandomizeOwnDirection", toggled_on)
	
func _on_numerical_heading_indicator_toggled(toggled_on):
	Configloader.save_game_options("NumericalHeadingIndicator", toggled_on)

func _on_analog_heading_indicator_toggled(toggled_on):
	Configloader.save_game_options("AnalogHeadingIndicator", toggled_on)

func _on_use_bullseye_toggled(toggled_on):
	Configloader.save_game_options("UseBullseye", toggled_on)
	
func _on_hmcs_toggled(toggled_on):
	Configloader.save_game_options("HMCS", toggled_on)

func _on_altitude_check_toggled(toggled_on):
	Configloader.save_game_options("AltitudeCheck", toggled_on)

func _on_mouse_sensitivity_text_changed(new_text):
	Configloader.save_control_options("MouseSensitivity", float(new_text))
	
func _on_timer_time_text_changed(new_text):
	Configloader.save_game_options("TimerTime", float(new_text))
	
func _on_allowable_directional_error_text_changed(new_text):
	Configloader.save_game_options("AllowableDirectionalError", float(new_text))
	
func _on_text_bullseye_toggled(toggled_on):
	Configloader.save_game_options("TextBullseye", toggled_on)

func _on_map_bullseye_toggled(toggled_on):
	Configloader.save_game_options("MapBullseye", toggled_on)

func _on_bullseye_visible_toggled(toggled_on):
	Configloader.save_game_options("BullseyeVisible", toggled_on)
	

func _on_easy_preset_pressed():
	Configloader.set_easy_preset()
	populate_settings()


func _on_default_preset_pressed():
	Configloader.set_defaults()
	populate_settings()

func _on_hard_preset_pressed():
	Configloader.set_hard_preset()
	populate_settings()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")
