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


func _ready():
	print("Global script initialized")

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
