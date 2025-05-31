extends Area2D

@export var target_scene: String
@export var target_door_name: String = ""
@export var puzzle_scene:= "res://scenes/LibraryLock.tscn" 
@export var library_scene_path := "res://scenes/library.tscn"

@export var is_puzzle_door: bool = false

func _ready():
	add_to_group("doors")
	print("Door initialized: ", name)

func _on_body_entered(body):
	if is_puzzle_door:
		handle_puzzle_door(body)
	else:
		handle_regular_door(body)

func handle_puzzle_door(body):
	if body.name == "Player":
		if Global.puzzle_library_solved:
			enter_library()
		else:
			open_puzzle()

func handle_regular_door(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player entered door: ", name)
		Global.last_door_name = target_door_name
		call_deferred("_change_scene", target_scene)

func open_puzzle():
	call_deferred("_change_scene", puzzle_scene)

func enter_library():
	call_deferred("_change_scene", library_scene_path)

func _change_scene(scene_path):
	get_tree().change_scene_to_file(scene_path)
