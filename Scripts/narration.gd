extends CanvasLayer

@onready var text_label = $RichTextLabel
@onready var typing_timer = $TypingTimer

var current_line = 0
var char_index = 0
var full_text = ""
var lines = []
var is_typing = false
var on_finished: Callable = Callable()
var first_intro_shown: bool = false
var computer_sound = preload("res://assets/Music/texting.mp3")
var audio_player: AudioStreamPlayer

func _ready():
	hide()
	text_label.bbcode_enabled = true
	
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.bus = "SFX"
	
	if computer_sound:
		audio_player.stream = computer_sound
		audio_player.volume_db = -7

func show_lines(new_lines: Array, finished_callback: Callable = Callable()):
	lines = new_lines
	current_line = 0
	on_finished = finished_callback
	show()
	show_next_line()

func show_next_line():
	if current_line >= lines.size():
		hide()
		if on_finished:
			on_finished.call()
		return
	
	full_text = lines[current_line]
	text_label.text = ""
	char_index = 0
	is_typing = true
	typing_timer.start()

func _on_typing_timer_timeout() -> void:
	if is_typing and char_index < full_text.length():
		var char = full_text[char_index]
		text_label.append_text(char)

		if char != " " and char != "\n" and char != "\t":
			play_typing_sound()

		char_index += 1

		if char_index >= full_text.length():
			is_typing = false
			typing_timer.stop()
			await get_tree().create_timer(0.1).timeout
			if audio_player:
				audio_player.stop()
	else:
		typing_timer.stop()
		is_typing = false


func play_typing_sound():
	if audio_player and audio_player.stream:
		audio_player.stop()
		audio_player.play()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") or (
		event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT
	):
		if is_typing:
			typing_timer.stop()
			text_label.text = full_text
			is_typing = false
			if audio_player:
				audio_player.stop()
		else:
			current_line += 1
			show_next_line()

func hide_dialog():
	hide()
	typing_timer.stop()
	is_typing = false
	text_label.text = ""
	lines.clear()
	current_line = 0
	full_text = ""
	if audio_player:
		audio_player.stop()
