extends Area2D

var dialog_started = false
var full_dialog = ""
var table_puzzle_scene:= "res://scenes/LibraryLock.tscn"

var dialog_data_intro = [
	{"speaker": "Дата-аналітик", "text": "Ох... хто б ти не був, але ти вчасно. Ти не приніс павербанк?", "portrait": "res://assets/portraits/dbSp.png"},
	{"speaker": "Дата-аналітик", "text": "Ні? Шкода.", "portrait": "res://assets/portraits/dbSp.png"},
	{"speaker": "Дата-аналітик", "text": "Жоден з цих старих ящиків не ожив… Але глянь сюди. ", "portrait": "res://assets/portraits/dbSp.png"}
]

var dialog_data_end = [
	{"speaker": "Дата-аналітик", "text": "І де ж я подів мої роздруковані дані?", "portrait": "res://assets/portraits/dbSp.png"}
]

var dialog_data_tables = [
	{"speaker": "Дата-аналітик", "text": "О, дякую. Допоможеш мені відновити записи?", "portrait": "res://assets/portraits/dbSp.png"}
]

func _on_body_entered(body):
	if body.name == "Player" and not Global.dialogs_played.has("db_specialist_intro"):
		Global.dialogs_played["db_specialist_intro"] = true
		start_library_dialog()
	elif body.name == "Player" and Inventory.items.has("tables") and Inventory.items["tables"] > 0 and not Global.is_table_solved:
		var dialog_manager = get_node("/root/Engeenering-class/DialogueManager")
		Global.dialogs_played["db_specialist_tables"] = true
		
		dialog_manager.start_dialog(dialog_data_tables)
		
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://scenes/tables_puzzle/DatabasePuzzle.tscn")
		
	elif body.name == "Player" and Global.dialogs_played.has("db_specialist_intro") and not Global.is_table_solved:
		var dialog_manager = get_node("/root/Engeenering-class/DialogueManager")
		dialog_manager.start_dialog(dialog_data_end)
	
		
		

func start_library_dialog():
	var dialog_manager = get_node("/root/Engeenering-class/DialogueManager")
	dialog_manager.start_dialog(dialog_data_intro)


#func _on_ready() -> void:
	#if Global.puzzle_library_solved:
		#$Sprite2D.visible = false
		
	#if Global.is_way_to_college_showed:
		#$Sprite2D.visible = true
