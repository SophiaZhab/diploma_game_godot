extends Area2D

@export var item_name: String = "flashlight"
@export var icon: Texture

func _ready():
	input_pickable = true
	print("Item is ready to be picked up")

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Item clicked: ", item_name)  # Debugging line
		if Inventory:
			Inventory.add_item(item_name, icon)
			print("Item added to inventory")  # Debugging line
		else:
			print("Inventory not found")
		queue_free()
