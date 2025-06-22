extends Node2D

func _ready() -> void:
	await get_tree().create_timer(10.0).timeout
	Global.clear_progress_only()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

var scroll_speed = 30 

func _process(delta):
	$CanvasLayer/Title.position.y -= scroll_speed * delta
	$CanvasLayer/Text.position.y -= scroll_speed * delta
	$CanvasLayer/Text2.position.y -= scroll_speed * delta
	$CanvasLayer/Text3.position.y -= scroll_speed * delta
