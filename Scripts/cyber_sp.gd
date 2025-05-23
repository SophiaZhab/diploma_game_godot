extends Area2D

var dialog_started = false

var dialog_data_intro = [
	{"speaker": "Кіберспеціалістка", "text": "О, тебе я раніше не бачила, ти хто?", "portrait": "res://assets/portraits/cyberSp.png"},
	{"speaker": "Гравець", "text": "Я не бував у цьому місті раніше.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Кіберспеціалістка", "text": "Зрозуміла.", "portrait": "res://assets/portraits/cyberSp.png"},
	{"speaker": "Гравець", "text": "Я спробую знайти інших. Ти не знаєш таке місце, як ВСП ППФК і щось там далі?", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Кіберспеціалістка", "text": "Ні.", "portrait": "res://assets/portraits/cyberSp.png"}
]

var dialog_data_library = [
	{"speaker": "Гравець", "text": "А в бібліотеку знаєш як ввійти?", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Кіберспеціалістка", "text": "Так, це я начепила кодовий замок. Щоб книги на розтопку не брали.  Ось, тримай від нього код.", "portrait": "res://assets/portraits/cyberSp.png"},
	{"action": "give_item", "name": "note-code", "icon": preload("res://assets/icons/note-code.png")},
]

var dialog_data_end = [
	{"speaker": "Гравець", "text": "Дякую.", "portrait": "res://assets/portraits/mainP.png"}
]

var dialog_data_end2 = [
	{"speaker": "Гравець", "text": "Дякую. Ще побачимось.", "portrait": "res://assets/portraits/mainP.png"}
]

func _on_body_entered(body):
	if body.name == "Player" and not Global.dialogs_played.has("cyber_specialist_intro"):
		Global.dialogs_played["cyber_specialist_intro"] = true
		var dialog_manager = get_node("/root/Station-building/DialogueManager")
		dialog_data_intro += dialog_data_end
		dialog_manager.start_dialog(dialog_data_intro)
	elif body.name == "Player" and Global.visited_library and not Global.dialogs_played.has("cyber_specialist_library"):
		Global.dialogs_played["cyber_specialist_library"] = true
		start_library_dialog()

func start_library_dialog():
	var dialog_manager = get_node("/root/Station-building/DialogueManager")
	dialog_data_library += dialog_data_end2
	dialog_manager.start_dialog(dialog_data_library)
