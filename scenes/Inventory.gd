extends Node

var items := {}  # item_name -> кількість
var ui: Node = null  # посилання на InventoryUI, за потреби

func add_item(item_name: String, icon: Texture):
	if items.has(item_name):
		items[item_name] += 1
	else:
		items[item_name] = 1

	print("Inventory: ", items)

	# Якщо є UI — оновити
	if ui:
		ui.update_inventory_ui(icon)
