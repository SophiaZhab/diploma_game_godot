extends Control

@export var inventory_ui_path: NodePath
@onready var inventory_ui = $InventoryGui
@onready var settings = $SettingsMenu

var zipper_sound = preload("res://assets/Music/zipper.mp3")
var audio_player: AudioStreamPlayer

func _ready():
	$InventoryButton.focus_mode = Control.FOCUS_NONE
	$SettingsButton.focus_mode = Control.FOCUS_NONE
	$InventoryButton.pressed.connect(_on_inventory_button_pressed)
	inventory_ui.close()

	$SettingsButton.pressed.connect(_on_settings_button_pressed)
	settings.close()

	mouse_filter = Control.MOUSE_FILTER_PASS

	audio_player = AudioStreamPlayer.new()
	audio_player.stream = zipper_sound
	audio_player.bus = "SFX"
	add_child(audio_player)


func _on_inventory_button_pressed():
	if settings.isOpen:
		return

	if inventory_ui.isOpen:
		inventory_ui.close()
		audio_player.play()
		Global.is_dialog_active = false
	else:
		inventory_ui.open()
		audio_player.play()
		Global.is_dialog_active = true

func _on_settings_button_pressed():
	if settings.isOpen:
		settings.close()
		Global.is_dialog_active = false
	else:
		if inventory_ui.isOpen:
			inventory_ui.close()
		settings.open()
		Global.is_dialog_active = true
