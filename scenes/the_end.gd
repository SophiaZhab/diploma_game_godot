extends Node2D

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	Global.clear_progress_only()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
