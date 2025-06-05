extends Node2D


func _ready():
	$StartButton.connect("pressed", _on_start_pressed)
	$ExitButton.connect("pressed", _on_exit_pressed)
	$NewGameButton.connect("pressed", _on_new_pressed)
	if not Music.get_node("Music").playing:
		Music.get_node("Music").play()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main_street.tscn")

func _on_exit_pressed():
	Global.save_game()
	Inventory.save_inventory()
	get_tree().quit()

func _on_new_pressed():
	Global.new_game()
