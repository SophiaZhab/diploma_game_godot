extends Area2D

var dialog_started = false

var dialog_data_intro = [
	{"speaker": "Спеціаліст з програмної інженерії", "text": "О, вітаю.", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Гравець", "text": "Привіт.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "Ти бачив залишене мною повідомлення і знайшов шлях сюди?", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Гравець", "text": "Саме так. Це було непросто.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "В нас попереду ще важче. Нам треба рятувати світ. ", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "І є труднощі. У тебе немає будь-якого джерела живлення?", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Гравець", "text": "Ні.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Гравець", "text": "Але я здогадуюсь, де його можна взяти.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "Було б чудово, якщо знайдеш.", "portrait": "res://assets/portraits/seSp.png"},
	{"speaker": "Спеціаліст з програмної інженерії", "text": "Також нам би ще когось. Нас тут троє, але схоже, що у інших вже опустилися руки...", "portrait": "res://assets/portraits/seSp.png"}
]

var dialog_data_end = [
	{"speaker": "Спеціаліст з програмної інженерії", "text": "На тобі пошук джерела живлення.", "portrait": "res://assets/portraits/seSp.png"}
]

func _on_body_entered(body):
	if body.name == "Player" and not Global.dialogs_played.has("se_specialist_intro"):
		Global.dialogs_played["se_specialist_intro"] = true
		start_library_dialog()
	elif body.name == "Player" and Global.dialogs_played.has("se_specialist_intro"):
		var dialog_manager = get_node("/root/College/DialogueManager")
		dialog_manager.start_dialog(dialog_data_end)

func start_library_dialog():
	var dialog_manager = get_node("/root/College/DialogueManager")
	dialog_manager.start_dialog(dialog_data_intro)


func _on_ready() -> void:
	if Global.puzzle_library_solved:
		$Sprite2D.visible = false
		
	if Global.is_way_to_college_showed:
		$Sprite2D.visible = true
