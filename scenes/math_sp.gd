extends Area2D

var dialog_started = false

var dialog_data_intro = [
	{"speaker": "Математик", "text": "Це все не те, чорт.", "portrait": "res://assets/portraits/mathSp.png"},
	{"speaker": "Гравець", "text": "Що сталось?", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Математик", "text": "О, привіт. Тепер нас більше?", "portrait": "res://assets/portraits/mathSp.png"},
	{"speaker": "Гравець", "text": "Схоже на те.", "portrait": "res://assets/portraits/mainP.png"},
	{"speaker": "Математик", "text": "Тримай ось ці роздруковані таблиці. Віднеси це нашому дата-аналітику, бо я сам не розберусь.", "portrait": "res://assets/portraits/mathSp.png"},
	{"speaker": "Математик", "text": "А я працюватиму далі.", "portrait": "res://assets/portraits/mathSp.png"},
	{"speaker": "Гравець", "text": "Добре, зараз віднесу.", "portrait": "res://assets/portraits/mainP.png"},
	{"action": "give_item", "name": "tables", "icon": preload("res://assets/icons/tables.png")}
]

var dialog_data_end = [
	{"speaker": "Математик", "text": "І де ж я подів мої роздруковані дані?", "portrait": "res://assets/portraits/dbSp.png"}
]

func _on_body_entered(body):
	if body.name == "Player" and not Global.dialogs_played.has("math_specialist_intro"):
		Global.dialogs_played["math_specialist_intro"] = true
		start_library_dialog()
	elif body.name == "Player" and Global.dialogs_played.has("math_specialist_intro"):
		var dialog_manager = get_node("/root/Second-class/DialogueManager")
		dialog_manager.start_dialog(dialog_data_end)

func start_library_dialog():
	var dialog_manager = get_node("/root/Second-class/DialogueManager")
	dialog_manager.start_dialog(dialog_data_intro)


#func _on_ready() -> void:
	#if Global.puzzle_library_solved:
		#$Sprite2D.visible = false
		
	#if Global.is_way_to_college_showed:
		#$Sprite2D.visible = true
