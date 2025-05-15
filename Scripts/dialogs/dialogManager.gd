extends CanvasLayer

var dialog_data = []
var current_index = 0

@onready var portrait_left = $PortraitLeft
@onready var portrait_right = $PortraitRight
@onready var name_label = $NameLabel
@onready var text_label = $TextLabel

func start_dialog(data: Array):
	dialog_data = data
	current_index = 0
	show()
	_show_line()

func _input(event):
	if visible and event.is_action_pressed("ui_accept"):
		current_index += 1
		if current_index < dialog_data.size():
			_show_line()
		else:
			hide()

func _show_line():
	var entry = dialog_data[current_index]
	if entry.has("action"):
		if entry.action == "give_code":
			Global.library_code = entry.code
			print("📄 Гравець отримав код:", entry.code)
		return

	name_label.text = entry.speaker
	text_label.text = entry.text

	if entry.speaker == "Гравець":
		portrait_right.texture = load(entry.portrait)
		portrait_left.texture = null
	else:
		portrait_left.texture = load(entry.portrait)
		portrait_right.texture = null
