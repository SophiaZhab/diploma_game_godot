extends Node

var items := {} 
var ui: Node = null

func add_item(item_name: String, icon: Texture):
	if items.has(item_name):
		items[item_name] += 1
	else:
		items[item_name] = 1

	print("Inventory: ", items)

	if ui:
		ui.update_inventory_ui(icon)

func save_inventory():
	var config = ConfigFile.new()
	for item_name in items.keys():
		config.set_value("inventory", item_name, items[item_name])
	config.save("user://inventory.cfg")

func load_inventory():
	items.clear()
	var config = ConfigFile.new()
	if config.load("user://inventory.cfg") == OK:
		if config.has_section("inventory"):
			var keys = config.get_section_keys("inventory")
			for item_name in keys:
				items[item_name] = config.get_value("inventory", item_name, 1)
	print("Loaded inventory: ", items)
