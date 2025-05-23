extends Node

var last_door_position = Vector2.ZERO
var last_door_name: String = ""
var puzzle_library_solved := false
var dialogs_played = {}
var visited_library := false
var is_dialog_active := false
var is_way_to_college_showed := false


func _ready():
	print("Global script initialized")
