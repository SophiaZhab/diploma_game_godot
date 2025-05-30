extends Area2D

var dialog_started = false

var dialog_data_intro = [
	{"speaker": "Кіберспеціалістка", "text": "Я все ж прийшла допомогти.", "portrait": "res://assets/portraits/cyberSp.png"}
]

func _on_body_entered(body):
	if body.name == "Player" and not Global.dialogs_played.has("cyber_specialist_intro") and Global.is_table_solved:
		Global.dialogs_played["cyber_specialist_intro"] = true
		var dialog_manager = get_node("/root/Station-building/DialogueManager")
		dialog_manager.start_dialog(dialog_data_intro)

func _on_ready() -> void:
	
	if Global.is_table_solved:
		$Sprite2D.visible = true
		$CyberSp_col/CollisionShape2D.disabled = false
