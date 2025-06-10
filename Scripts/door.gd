extends Area2D
@export var target_scene: String
@export var target_door_name: String = ""
@export var puzzle_scene:= "res://scenes/LibraryLock.tscn" 
@export var library_scene_path := "res://scenes/library.tscn"
@export_group("Door Type")
@export var is_puzzle_door: bool = false
@export var is_key_door: bool = false
@export var required_key: String = "Key"
@export var play_sound: bool = true 

var door_sound = preload("res://assets/Music/door.mp3")
var audio_player: AudioStreamPlayer

func _ready():
	add_to_group("doors")
	print("Door initialized: ", name)
	
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = door_sound
	add_child(audio_player)

func _on_body_entered(body):
	if is_puzzle_door:
		handle_puzzle_door(body)
	elif is_key_door:
		handle_key_door(body)
	else:
		handle_regular_door(body)

func handle_puzzle_door(body):
	if body.name == "Player" or body.is_in_group("player"):
		print("Player entered puzzle door")
		if Global.puzzle_library_solved:
			if play_sound:
				play_door_sound()
			enter_library()
		else:
			open_puzzle()

func handle_key_door(body):
	if body.name == "Player" or body.is_in_group("player"):
		if Inventory.items.has(required_key) and Inventory.items[required_key] > 0:
			if play_sound:
				play_door_sound()
			Global.last_door_name = target_door_name
			call_deferred("_change_scene", target_scene)
		else:
			NarrationManager.show_lines([
				"Зачинено на ключ."
			])

func handle_regular_door(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player entered regular door: ", name)
		if play_sound:
			play_door_sound()
		Global.last_door_name = target_door_name
		call_deferred("_change_scene", target_scene)

func open_puzzle():
	print("Opening puzzle")
	call_deferred("_change_scene", puzzle_scene)

func enter_library():
	print("Entering library")
	call_deferred("_change_scene", library_scene_path)

func play_door_sound():
	if audio_player and door_sound:
		audio_player.play()
		print("Playing door sound")

func _change_scene(scene_path):
	print("Changing scene to: ", scene_path)
	get_tree().change_scene_to_file(scene_path)
