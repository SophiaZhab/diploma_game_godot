extends Panel

var accepted_type := "row_block"
var is_occupied := false

func _can_drop_data(position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has("type") and data["type"] == accepted_type

func _drop_data(position: Vector2, data: Variant) -> void:
	if not _can_drop_data(position, data):
		return

	var new_node := data["node"]
	var old_parent := new_node.get_parent()

	# Якщо слот вже зайнятий — обмінятися елементами
	if is_occupied and get_child_count() > 0:
		var existing_node := get_child(0)
		
		# Вилучити обидва з батьків
		remove_child(existing_node)
		if old_parent:
			old_parent.remove_child(new_node)

		# Обмін місцями
		old_parent.add_child(existing_node)
		existing_node.position = Vector2.ZERO
		
		add_child(new_node)
		new_node.position = Vector2.ZERO

	else:
		# Просто перемістити
		if old_parent:
			old_parent.remove_child(new_node)

		add_child(new_node)
		new_node.position = Vector2.ZERO
		is_occupied = true
