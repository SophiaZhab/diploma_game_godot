extends Node

var items := {} 
var ui: Node = null

func add_item(item_name: String, icon: Texture):
	if items.has(item_name):
		items[item_name] += 1
	else:
		items[item_name] = 1

	print("Inventory: ", items)

	# Якщо є UI — оновити
	if ui:
		ui.update_inventory_ui(icon)
