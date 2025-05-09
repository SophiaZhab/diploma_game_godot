extends Node2D


func _ready():
	$StartButton.connect("pressed", _on_start_pressed)
	$ExitButton.connect("pressed", _on_exit_pressed)
	

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main_street.tscn")

func _on_exit_pressed():
	get_tree().quit()
