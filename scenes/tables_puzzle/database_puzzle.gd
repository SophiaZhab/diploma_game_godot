extends Control

func _ready():
	NarrationManager.show_lines([
			"Твоє завдання — відновити структуру бази даних.",
			"Поглянь, тут три таблиці.",
			"Треба, щоб ти правильно розставив поля у відповідні слоти. ",
			"А також для кожного поля обери правильний тип даних. "
		])
	add_to_group("checkers")
	print("Checker ready, додано до групи checkers")
	await get_tree().process_frame  
	connect_all_option_buttons()

func connect_all_option_buttons():
	print("Починаємо пошук OptionButton...")
	find_and_connect_option_buttons(self)

func find_and_connect_option_buttons(node: Node):
	if node is OptionButton:
		print("Знайдено OptionButton: ", node.get_path())
		if not node.item_selected.is_connected(check_solution):
			node.item_selected.connect(check_solution.bind())
			print("Підключено сигнал для OptionButton: ", node.get_path())
		else:
			print("Сигнал уже підключений для: ", node.get_path())
	
	for child in node.get_children():
		find_and_connect_option_buttons(child)

func check_solution(_index = -1): 
	var correct_structure = {
		"DropSlot3": [
			{"name": "id", "type": "ЧИСЛО"},
			{"name": "id користувача", "type": "ЧИСЛО"},
			{"name": "MAC-адреса мережі", "type": "ТЕКСТ"},
			{"name": "час ост. користув.", "type": "ДАТА,час"}
		],
		"DropSlot1": [
			{"name": "id", "type": "ЧИСЛО"},
			{"name": "ім'я", "type": "ТЕКСТ"},
			{"name": "пошта", "type": "ТЕКСТ"},
			{"name": "дата_реєстрації", "type": "ДАТА"}
		],
		"DropSlot2": [
			{"name": "id", "type": "ЧИСЛО"},
			{"name": "id користувача", "type": "ЧИСЛО"},
			{"name": "опис дії", "type": "ТЕКСТ"},
			{"name": "час дії", "type": "ДАТА,час"}
		]
	}

	var all_correct = true

	for slot_name in correct_structure.keys():
		var slot = $Values.get_node(slot_name)

		if slot.get_child_count() == 0:
			all_correct = false
			break

		var vbox = slot.get_child(0)
		var expected = correct_structure[slot_name]

		var field_rows = []
		for child in vbox.get_children():
			if child is HBoxContainer:
				field_rows.append(child)

		if field_rows.size() != expected.size():
			all_correct = false
			break

		for i in range(expected.size()):
			var row = field_rows[i]
			var label = row.get_node("Label")
			var option = row.get_node("OptionButton")

			var selected_index = option.get_selected()
			var selected_type = ""
			if selected_index >= 0:
				selected_type = option.get_item_text(selected_index)

			var actual_name = label.text.strip_edges().replace("\n", " ")

			if actual_name != expected[i]["name"] or selected_type != expected[i]["type"]:
				all_correct = false
				break

		if not all_correct:
			break

	if all_correct:
		NarrationManager.show_lines([
			"Молодець, наче все правильно.",
			"Дякую за допомогу.",
		])
		Global.is_table_solved = true
		await get_tree().create_timer(2.0).timeout
		get_tree().change_scene_to_file("res://scenes/engeenering-class.tscn")
		if Inventory.items.has("tables"):
			Inventory.items.erase("tables")
