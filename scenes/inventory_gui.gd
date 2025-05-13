extends Control

@onready var container := $NinePatchRect/GridContainer
@onready var inventory_slot_scene := preload("res://scenes/slot_gui.tscn")
@onready var flashlight_texture := preload("res://assets/icons/flashlights.png")

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
	# Remove all children of the container
	for child in container.get_children():
		child.queue_free()
	
	for item_name in Inventory.items.keys():
		var slot = inventory_slot_scene.instantiate()
		
		# Find the correct node paths - adjust these to match your actual scene hierarchy
		# Check your slot_gui.tscn to find the correct paths
		var icon_node = slot.find_child("TextureRect") # Common name for texture nodes
		#var count_label = slot.find_child("Label") # Common name for label nodes
		
		# Alternatively, if you know the exact paths:
		# var icon_node = slot.get_node("TextureRect") 
		# var count_label = slot.get_node("Label")
		
		# Debug output to help find node names
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

# Helper function to get the appropriate texture for each item type
func get_item_texture(item_name: String) -> Texture:
	match item_name:
		"flashlight":
			return flashlight_texture
		# Add more items here as needed
		# "medkit":
		#    return medkit_texture
		_:
			# Default texture or placeholder for unknown items
			# You might want to load a default/missing texture here
			return null  # Or return a default texture
