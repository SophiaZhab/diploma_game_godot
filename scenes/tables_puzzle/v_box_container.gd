extends Control

func _can_drop_data(position, data):
	return data is VBoxContainer and has_node(data.get_path())

func _drop_data(position, data):
	if data is VBoxContainer and has_node(data.get_path()):
		var drop_at = get_drop_position(position)
		remove_child(data)
		add_child(data)
		move_child(data, drop_at)
		
func get_drop_position(position: Vector2) -> int:
	for i in get_child_count():
		var child := get_child(i)
		if position.y < child.global_position.y + child.size.y / 2:
			return i
	return get_child_count()
	
