extends Control

@onready var container := $NinePatchRect/GridContainer
@onready var inventory_slot_scene := preload("res://scenes/slot_gui.tscn")
@onready var flashlight_texture := preload("res://assets/icons/flashlights.png")
@onready var shovel_texture := preload("res://assets/icons/shovel.png")
@onready var key_texture := preload("res://assets/icons/station-key.png")

var isOpen: bool = false

func _ready():
	visible = false
	isOpen = false
	Inventory.ui = self  
	update_inventory_ui()

func open():
	visible = true
	isOpen = true

func close():
	visible = false
	isOpen = false

func update_inventory_ui(icon: Texture = null):

	for child in container.get_children():
		child.queue_free()
	
	for item_name in Inventory.items.keys():
		var slot = inventory_slot_scene.instantiate()
		

		var icon_node = slot.find_child("TextureRect")
	
		print("Available children in slot: ", slot.get_children())
		
		if icon_node:
			# You need to load the correct texture for each item
			var item_texture = get_item_texture(item_name)
			icon_node.texture = item_texture
		else:
			push_error("Could not find texture node in slot")
			
		#if count_label:
			#count_label.text = str(Inventory.items[item_name])
		#else:
			#push_error("Could not find label node in slot")
			
		container.add_child(slot)


func get_item_texture(item_name: String) -> Texture:
	match item_name:
		"flashlight":
			return flashlight_texture
		"shovel":
			return shovel_texture
		"stationKey":
			return key_texture
		_:
		
			return null  
