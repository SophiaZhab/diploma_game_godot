extends Area2D

@export var item_name: String = "Unnamed Item"
@export var icon: Texture
@export var auto_pickup: bool = false 

func _ready():
	if Global.is_item_picked(item_name):
		queue_free()
		return

	input_pickable = true
	print("Item ready: ", item_name)
	
	if auto_pickup:
		connect("body_entered", Callable(self, "_on_body_entered"))


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_add_to_inventory()
		

func _on_body_entered(body):
	if body.name == "Player":
		_add_to_inventory()

func _add_to_inventory():
	if has_node("/root/Inventory"):
		var inventory = get_node("/root/Inventory")
		inventory.add_item(item_name, icon)

		Global.mark_item_picked(item_name)
		
		if has_node("/root/NarrationManager"):
			var narration = get_node("/root/NarrationManager")
			
			match item_name:
				"flashlight":
					narration.show_lines([
						"Піднято ліхтарик.",
						"Тепер можна йти досліджувати місто.",
						"А ці літери у записці поки мені ні про що не говорять..."
					])
				"Note":
					narration.show_lines([
						"Записка: «Якщо ти хочеш допомогти — йди до коледжу.»"
					])
				"book1":
					narration.show_lines([
						"Піднято: книжка, 1 шт."
					])
				"book2":
					narration.show_lines([
						"Книжка?"
					])
				"stationKey":
					narration.show_lines([
						"Іржавий ключ."
					])
				"book3":
					narration.show_lines([
						"Книжка з цифрами..."
					])
				_: 
					narration.show_lines([
						"Ти підняв: " + item_name
					])
	else:
		print("Inventory not found")
	
	queue_free()

	


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_add_to_inventory()
