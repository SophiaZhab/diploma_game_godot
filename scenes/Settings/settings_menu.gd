extends Control

@onready var music_slider = $VBoxContainer/MusicSlider
@onready var sfx_slider = $VBoxContainer/SFXSlider
@onready var continue_button = $Button

var isOpen: bool = false

func _ready():
	visible = false
	isOpen = false
	if Global.is_menu:
		continue_button.visible = false

	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var vol = config.get_value("audio", "music_volume", 1.0)
		music_slider.value = vol
		_update_music_volume(vol)
		var sfx_vol = config.get_value("audio", "sfx_volume", 1.0)
		sfx_slider.value = sfx_vol
		_update_sfx_volume(sfx_vol)


	music_slider.value_changed.connect(_on_music_slider_value_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_value_changed)
	$Button.pressed.connect(_on_apply_button_pressed)
	$ButtonMenu.pressed.connect(_on_menu_button_pressed)
	
	randomize()


func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false
	_save_settings()

func _on_music_slider_value_changed(value: float) -> void:
	_update_music_volume(value)

func _update_music_volume(value: float) -> void:
	var db = linear2db(value)
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, db)

func linear2db(value: float) -> float:
	if value <= 0.0:
		return -80.0
	return 20.0 * log(value) / log(10.0)

func _save_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "music_volume", music_slider.value)
	config.set_value("audio", "sfx_volume", sfx_slider.value)
	config.save("user://settings.cfg")

func _on_Back_pressed():
	close()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_apply_button_pressed():
	close()
	Global.is_dialog_active = false

func _on_menu_button_pressed():
	NarrationManager.hide_dialog()
	close()
	Global.is_dialog_active = false
	Global.is_menu = true
	get_tree().change_scene_to_file("res://scenes/Main.tscn")

func _on_sfx_slider_value_changed(value: float) -> void:
	_update_sfx_volume(value)

func _update_sfx_volume(value: float) -> void:
	var db = linear2db(value)
	var bus_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_index, db)
