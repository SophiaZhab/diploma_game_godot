extends Node2D

var generator_sound = preload("res://assets/Music/generator.mp3")
var audio_player: AudioStreamPlayer

func _ready() -> void:
	Global.footstep_type = "indoor" 
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = generator_sound
	audio_player.bus = "SFX"
	audio_player.volume_db = -5
	add_child(audio_player)
	
	if Global.generator_running:
		if not audio_player.is_playing():
				audio_player.play()  
	
