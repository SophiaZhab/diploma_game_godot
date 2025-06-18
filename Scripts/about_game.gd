extends Control

var isOpen: bool = false

func _ready():
	visible = false
	isOpen = false
	
	$Button.pressed.connect(_on_menu_button_pressed)

func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false
	
func _on_menu_button_pressed():
	close()
	get_tree().change_scene_to_file("res://scenes/Main.tscn")
