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

func _ready():
	hide()
	text_label.bbcode_enabled = true

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
		text_label.append_text(full_text[char_index])
		char_index += 1
	else:
		typing_timer.stop()
		is_typing = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") or (
		event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT
	):
		if is_typing:
			typing_timer.stop()
			text_label.text = full_text
			is_typing = false
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
