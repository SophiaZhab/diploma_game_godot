extends Node

var last_door_position = Vector2.ZERO
var last_door_name: String = ""
var puzzle_library_solved := false
var dialogs_played = {}
var visited_library := false
var is_dialog_active := false
var is_way_to_college_showed := false
var picked_items := {}
var triggered_dialogs = {}
var is_dragging = false
var is_table_solved = false
var footstep_type = "outdoor"
var is_new_game := false



func _ready():
	print("Global script initialized")
	if not is_new_game:
		load_game()
		Inventory.load_inventory()


func mark_item_picked(item_name: String) -> void:
	picked_items[item_name] = true
	_save_picked_items()

func is_item_picked(item_name: String) -> bool:
	return picked_items.has(item_name)

func _save_picked_items() -> void:
	var config = ConfigFile.new()
	for item_name in picked_items.keys():
		config.set_value("picked", item_name, true)
	config.save("user://picked_items.cfg")

func load_picked_items() -> void:
	var config = ConfigFile.new()
	if config.load("user://picked_items.cfg") == OK:
		var keys = config.get_section_keys("picked")
		if keys:
			for item_name in keys:
				picked_items[item_name] = true

func save_game() -> void:
	var config = ConfigFile.new()

	config.set_value("player", "last_door_position", last_door_position)
	config.set_value("player", "last_door_name", last_door_name)

	config.set_value("progress", "puzzle_library_solved", puzzle_library_solved)
	config.set_value("progress", "visited_library", visited_library)
	config.set_value("progress", "is_way_to_college_showed", is_way_to_college_showed)
	config.set_value("progress", "is_table_solved", is_table_solved)
	config.set_value("progress", "footstep_type", footstep_type)

	for key in picked_items.keys():
		config.set_value("picked", key, true)

	for dialog in dialogs_played.keys():
		config.set_value("dialogs", dialog, true)

	for trigger in triggered_dialogs.keys():
		config.set_value("triggers", trigger, true)

	config.save("user://save.cfg")

func load_game() -> void:
	var config = ConfigFile.new()
	if config.load("user://save.cfg") != OK:
		print("Немає збереженого файлу.")
		return

	last_door_position = config.get_value("player", "last_door_position", Vector2.ZERO)
	last_door_name = config.get_value("player", "last_door_name", "")

	puzzle_library_solved = config.get_value("progress", "puzzle_library_solved", false)
	visited_library = config.get_value("progress", "visited_library", false)
	is_way_to_college_showed = config.get_value("progress", "is_way_to_college_showed", false)
	is_table_solved = config.get_value("progress", "is_table_solved", false)
	footstep_type = config.get_value("progress", "footstep_type", "outdoor")

	if config.has_section("picked"):
		for key in config.get_section_keys("picked"):
			picked_items[key] = true

	if config.has_section("dialogs"):
		for key in config.get_section_keys("dialogs"):
			dialogs_played[key] = true

	if config.has_section("triggers"):
		for key in config.get_section_keys("triggers"):
			triggered_dialogs[key] = true

func new_game():
	var save_files = [
		"user://save.cfg",
		"user://inventory.cfg",
		"user://picked_items.cfg"
	]

	for file_path in save_files:
		if FileAccess.file_exists(file_path):
			DirAccess.remove_absolute(file_path)

	last_door_position = Vector2.ZERO
	last_door_name = ""
	puzzle_library_solved = false
	dialogs_played.clear()
	visited_library = false
	is_dialog_active = false
	is_way_to_college_showed = false
	picked_items.clear()
	triggered_dialogs.clear()
	is_dragging = false
	is_table_solved = false
	footstep_type = "outdoor"
	is_new_game = true
	Inventory.items.clear()


	if Engine.has_singleton("Inventory"):
		Inventory.items.clear()

	get_tree().change_scene_to_file("res://scenes/main_street.tscn") 
