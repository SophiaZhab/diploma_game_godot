extends Control

@onready var container := $NinePatchRect/GridContainer
@onready var inventory_slot_scene := preload("res://scenes/slot_gui.tscn")
@onready var flashlight_texture := preload("res://assets/icons/flashlights.png")
@onready var shovel_texture := preload("res://assets/icons/shovel.png")
@onready var key_texture := preload("res://assets/icons/station-key.png")
@onready var book1_texture := preload("res://assets/icons/book1.png")
@onready var book2_texture := preload("res://assets/icons/book2.png")
@onready var book3_texture := preload("res://assets/icons/book3.png")
@onready var notecode_texture := preload("res://assets/icons/note-code.png")
@onready var tables_texture := preload("res://assets/icons/tables.png")

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
		var name_label = slot.get_node("ItemNameLabel")
	
		print("Available children in slot: ", slot.get_children())
		
		if icon_node and name_label:
			var item_texture = get_item_texture(item_name)
			icon_node.texture = item_texture
			name_label.text = get_item_label(item_name)
			name_label.visible = false  # спочатку приховано

			icon_node.connect("mouse_entered", Callable(self, "_on_icon_mouse_entered").bind(name_label))
			icon_node.connect("mouse_exited", Callable(self, "_on_icon_mouse_exited").bind(name_label))
		else:
			push_error("Could not find texture or label node in slot")
			
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
		"book1":
			return book1_texture
		"book2":
			return book2_texture
		"book3":
			return book3_texture
		"tables":
			return tables_texture
		"note-code":
			return notecode_texture
		_:
		
			return null  

func get_item_label(item_name: String) -> String:
	match item_name:
		"flashlight":
			return "Ліхтарик"
		"shovel":
			return "Лопата"
		"stationKey":
			return "Іржавий ключ"
		"book1":
			return "Сіра книга"
		"book2":
			return "Червона книга"
		"book3":
			return "Зелена книга"
		"tables":
			return "Документи"
		"note-code":
			return "Код від бібліотеки"
		_:
		
			return "" 			

func _on_icon_mouse_entered(label: Label):
	label.visible = true

func _on_icon_mouse_exited(label: Label):
	label.visible = false
