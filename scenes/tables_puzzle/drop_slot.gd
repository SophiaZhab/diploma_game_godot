extends Panel

func _can_drop_data(_position, data):
	return data is VBoxContainer

func _drop_data(_position, data):
	if not (data is VBoxContainer):
		return
	
	var other = get_child(0) if get_child_count() > 0 else null
	
	if other == null:
		if data.get_parent():
			data.get_parent().remove_child(data)
		add_child(data)
	else:
		var source_slot = data.get_parent()
		var other_slot = other.get_parent()
		if source_slot and other_slot:
			source_slot.remove_child(data)
			other_slot.remove_child(other)
			source_slot.add_child(other)
			other_slot.add_child(data)
	
	get_tree().call_group("checkers", "reconnect_all_signals")
	get_tree().call_group("checkers", "check_solution")
