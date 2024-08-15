extends Node

var config = ConfigFile.new()
const OPTIONS_FILE_PATH = "user://options.cfg"

func set_defaults():
	config.set_value("Game Options", "UseBullseye", false)
	config.set_value("Game Options", "BullseyeVisible", false)
	config.set_value("Game Options", "TextBullseye", true)
	
	config.set_value("Game Options", "MapBullseye", true)
	
	config.set_value("Game Options", "TargetsVisible", false)
	config.set_value("Game Options", "Subtitles", false)
	
	config.set_value("Game Options", "RandomizeOwnDirection", true)
	config.set_value("Game Options", "NumericalHeadingIndicator", true)
	config.set_value("Game Options", "AnalogHeadingIndicator", true)

	config.set_value("Game Options", "TimerTime", 10)
	config.set_value("Game Options", "AllowableDirectionalError", 45)
	config.set_value("Control Options", "MouseSensitivity", 1)
	
	config.save("user://options.cfg")
	
func set_easy_preset():
	config.set_value("Game Options", "UseBullseye", true)
	config.set_value("Game Options", "BullseyeVisible", true)
	config.set_value("Game Options", "TextBullseye", true)
	
	config.set_value("Game Options", "MapBullseye", true)
	
	config.set_value("Game Options", "TargetsVisible", true)
	config.set_value("Game Options", "Subtitles", true)
	
	config.set_value("Game Options", "RandomizeOwnDirection", false)
	config.set_value("Game Options", "NumericalHeadingIndicator", true)
	config.set_value("Game Options", "AnalogHeadingIndicator", true)

	config.set_value("Game Options", "TimerTime", 15)
	config.set_value("Game Options", "AllowableDirectionalError", 45)
	config.set_value("Control Options", "MouseSensitivity", 1)
	
	config.save("user://options.cfg")
	
func set_hard_preset():
	config.set_value("Game Options", "UseBullseye", true)
	config.set_value("Game Options", "BullseyeVisible", false)
	config.set_value("Game Options", "TextBullseye", true)
	
	config.set_value("Game Options", "MapBullseye", false)
	
	config.set_value("Game Options", "TargetsVisible", false)
	config.set_value("Game Options", "Subtitles", false)
	
	config.set_value("Game Options", "RandomizeOwnDirection", true)
	config.set_value("Game Options", "NumericalHeadingIndicator", true)
	config.set_value("Game Options", "AnalogHeadingIndicator", false)

	config.set_value("Game Options", "TimerTime", 10)
	config.set_value("Game Options", "AllowableDirectionalError", 30)
	config.set_value("Control Options", "MouseSensitivity", 1)
	
	config.save("user://options.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Checks if file does NOT exist yet, if NOT, sets default values.
	if !FileAccess.file_exists(OPTIONS_FILE_PATH):
		set_defaults()
	else:
		config.load(OPTIONS_FILE_PATH)

func save_game_options(key: String, value):
	config.set_value("Game Options", key, value)
	config.save(OPTIONS_FILE_PATH)

func save_control_options(key: String, value):
	config.set_value("Control Options", key, value)
	config.save(OPTIONS_FILE_PATH)
	
func load_game_options():
	var gameoptions = {}
	for key in config.get_section_keys("Game Options"):
		gameoptions[key] = config.get_value("Game Options", key)
	return gameoptions
	
func load_control_options():
	var controloptions = {}
	for key in config.get_section_keys("Control Options"):
		controloptions[key] = config.get_value("Control Options", key)
	return controloptions
