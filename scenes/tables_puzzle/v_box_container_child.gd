extends VBoxContainer

func _get_drag_data(_position):
	set_drag_preview(duplicate())
	return self
	
func _on_OptionButton_item_selected(index):
	get_tree().call_group("checkers", "check_solution")
