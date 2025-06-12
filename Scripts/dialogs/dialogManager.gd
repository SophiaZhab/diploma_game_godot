extends CanvasLayer

var dialog_data = []
var current_index = 0
var item_to_add: Dictionary = {}
var full_text = ""
var char_index = 0
var is_typing = false
var computer_sound = preload("res://assets/Music/texting.mp3")
var audio_player: AudioStreamPlayer

@onready var portrait_left = $PortraitLeft
@onready var portrait_right = $PortraitRight
@onready var name_label = $NameLabel
@onready var text_label = $TextLabel

func start_dialog(data: Array, item: Dictionary = {}):
	Global.is_dialog_active = true
	dialog_data = data
	current_index = 0
	item_to_add = item
	show()
	show_line()
	audio_player.bus = "SFX"

func _input(event):
	if not visible:
		return
	var should_continue = false
	
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		should_continue = true
		get_viewport().set_input_as_handled()
	
	if should_continue:
		if is_typing:
			$TypingTimer.stop()
			text_label.text = full_text
			is_typing = false
			if audio_player:
				audio_player.stop()
		else:
			current_index += 1
			show_line()

func _ready():
	hide()
	$TypingTimer.connect("timeout", Callable(self, "_on_TypingTimer_timeout"))
	
	audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	
	if computer_sound:
		audio_player.stream = computer_sound
		audio_player.volume_db = -7

func end_dialog():
	Global.is_dialog_active = false
	hide()
	
	if audio_player:
		audio_player.stop()
	
	if item_to_add.has("name") and item_to_add.has("icon"):
		Inventory.add_item(item_to_add.name, item_to_add.icon)
		if item_to_add.name == "code-note":
			NarrationManager.show_lines(["Записку додано до інвентарю."])
		if item_to_add.name == "tables":
			NarrationManager.show_lines(["Документи додані до інвентарю."])
	
	item_to_add = {}
	dialog_data = []

func show_line():
	if current_index >= dialog_data.size():
		end_dialog()
		return
		
	var entry = dialog_data[current_index]
	
	if entry.has("action"):
		if entry.action == "give_code":
			Global.library_code = entry.code
		elif entry.action == "give_item":
			item_to_add = { "name": entry.name, "icon": entry.icon }
		
		current_index += 1
		show_line()
		return
	
	name_label.text = entry.speaker
	
	full_text = entry.text
	text_label.text = ""
	char_index = 0
	is_typing = true
	
	if full_text.length() > 0:
		$TypingTimer.start()
		_on_TypingTimer_timeout()
	else:
		is_typing = false
	
	if entry.speaker == "Гравець":
		portrait_right.texture = load(entry.portrait)
		portrait_left.texture = null
	else:
		portrait_left.texture = load(entry.portrait)
		portrait_right.texture = null

func play_typing_sound():
	if audio_player and audio_player.stream:
		audio_player.stop()
		audio_player.play()

func _on_TypingTimer_timeout():
	if is_typing and char_index < full_text.length():
		var char = full_text[char_index]
		text_label.append_text(char)
		
		if char != " " and char != "\n" and char != "\t":
			play_typing_sound()
		
		char_index += 1

		if char_index >= full_text.length():
			is_typing = false
			$TypingTimer.stop()

			await get_tree().create_timer(0.1).timeout
			if audio_player:
				audio_player.stop()
	else:
		is_typing = false
		$TypingTimer.stop()
