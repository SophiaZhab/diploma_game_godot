extends Control

@export var inventory_ui_path: NodePath
@onready var inventory_ui = $InventoryGui

func _ready():
	$InventoryButton.pressed.connect(_on_inventory_button_pressed)
	inventory_ui.close()
	mouse_filter = MOUSE_FILTER_IGNORE

	

func _on_inventory_button_pressed():
	if inventory_ui.isOpen:
		inventory_ui.close()
	else:
		inventory_ui.open()
