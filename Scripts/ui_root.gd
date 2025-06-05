extends Control

@export var inventory_ui_path: NodePath
@onready var inventory_ui = $InventoryGui
@onready var settings = $SettingsMenu

func _ready():
	$InventoryButton.focus_mode = Control.FOCUS_NONE
	$SettingsButton.focus_mode = Control.FOCUS_NONE
	$InventoryButton.pressed.connect(_on_inventory_button_pressed)
	inventory_ui.close()

	$SettingsButton.pressed.connect(_on_settings_button_pressed)
	settings.close()

	mouse_filter = Control.MOUSE_FILTER_PASS



func _on_inventory_button_pressed():
	if settings.isOpen:
		return

	if inventory_ui.isOpen:
		inventory_ui.close()
		Global.is_dialog_active = false
	else:
		inventory_ui.open()
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
