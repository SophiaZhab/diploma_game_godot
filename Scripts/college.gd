extends Node2D

var generator_sound = preload("res://assets/Music/generator.mp3")
var audio_player: AudioStreamPlayer
var dialog_started = false
var dialog_data_db = [
	{"speaker": "Дата-аналітик", "text": "Я не вірю в те, що я чую. Тобі вдалося.", "portrait": "res://assets/portraits/dbSp.png"},
	{"speaker": "Математик", "text": "Невже це не кінець?", "portrait": "res://assets/portraits/mathSp.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "Який кінець? Звичайно ні.", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "Роботи багато, але я вірю, що нашою сильною командою ми все зможемо.", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Кіберспеціалістка", "text": "Буду рада, якщо буду корисна.", "portrait": "res://assets/portraits/cyberSp.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "Звичайно. Вітаю у команді.", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "І тебе, наш дорогий Гравцю.", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "Ти плідно попрацював і довів на що здатен, якби не ти, можливо б всього цього не було..", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Гравець", "text": "Дякую.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "А зараз, гайда до роботи, вперед у майбутнє.", "portrait": "res://assets/portraits/seSp.png"},
]

func _ready() -> void:
	Global.footstep_type = "indoor" 
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = generator_sound
	audio_player.bus = "SFX"
	audio_player.volume_db = -20
	add_child(audio_player)
	
	if Global.generator_running:
		if not audio_player.is_playing():
				audio_player.play()  
		await get_tree().create_timer(4.0).timeout
		Global.dialogs_played["outro"] = true
		var dialog_manager = get_node("/root/College/DialogueManager")
		dialog_manager.start_dialog(dialog_data_db)
		await get_tree().create_timer(25.0).timeout
		get_tree().change_scene_to_file("res://scenes/TheEnd.tscn")
	
