extends Node2D

@onready var settings = $SettingsMenu
@onready var about = $AboutGame

func _ready():
	$StartButton.connect("pressed", _on_start_pressed)
	
	$ExitButton.connect("pressed", _on_exit_pressed)
	$NewGameButton.connect("pressed", _on_new_pressed)
	$SettingsButton.connect("pressed", _on_settings_pressed)
	$AboutButton.connect("pressed", _on_about_pressed)
	$AboutButton.focus_mode = Control.FOCUS_NONE
	settings.close()
	
	if not Music.get_node("Music").playing:
		Music.get_node("Music").play()
	


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/main_street.tscn")
	Global.is_menu = false
	
func _on_exit_pressed():
	Global.save_game()
	Inventory.save_inventory()
	get_tree().quit()

func _on_new_pressed():
	Global.is_menu = false
	Global.new_game()
	
func _on_settings_pressed():
	settings.open()

func _on_about_pressed():
	about.open()
