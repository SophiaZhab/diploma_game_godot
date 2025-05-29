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

var dialog_data_generator = [
	{"speaker": "Гравець", "text": "Привіт ще раз. Послухай, є вихід, я знайшов команду.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Гравець", "text": "Але нам необхідно отримати живлення, ти можеш віддати нам генератор, що живить твій комп'ютер?", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Кіберспеціалістка", "text": "Але я майже вийшла в мережу...", "portrait": "res://assets/portraits/cyberSp.png"},
	{"speaker": "Гравець", "text": "Ти можеш доєднатись до нас і пробувати ще там.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Кіберспеціалістка", "text": "Можна мені час подумати?", "portrait": "res://assets/portraits/cyberSp.png"},
	{"speaker": "Гравець", "text": "Звичайно.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Гравець", "text": "Коли надумаєш, шлях до коледжу на моніторі.", "portrait": "res://assets/portraits/mainP.png"},
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
	elif body.name == "Player" and Global.dialogs_played.has("se_specialist_intro") and not Global.dialogs_played.has("cyber_specialist_generator"):
		Global.dialogs_played["cyber_specialist_generator"] = true
		var dialog_manager = get_node("/root/Station-building/DialogueManager")
		dialog_manager.start_dialog(dialog_data_generator)

func start_library_dialog():
	var dialog_manager = get_node("/root/Station-building/DialogueManager")
	dialog_data_library += dialog_data_end2
	dialog_manager.start_dialog(dialog_data_library)


func _on_ready() -> void:
	if Global.puzzle_library_solved:
		$Sprite2D.visible = false
		
	if Global.is_way_to_college_showed:
		$Sprite2D.visible = true
