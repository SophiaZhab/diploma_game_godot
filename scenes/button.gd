extends Area2D

@export var plug_node: Area2D

var enabled: bool = false
var generator_sound = preload("res://assets/Music/generator.mp3")
var audio_player: AudioStreamPlayer


func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = generator_sound
	audio_player.bus = "SFX"
	add_child(audio_player)
	input_pickable = true
	modulate = Color.GRAY
	if plug_node:
		plug_node.object_snapped.connect(_on_plugged)

func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if enabled and event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not audio_player.is_playing():
			audio_player.play()  
		Global.generator_running = true
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/College.tscn")
		

func _on_plugged() -> void:
	enabled = true
	modulate = Color.WHITE
