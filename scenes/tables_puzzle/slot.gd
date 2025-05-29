extends TextureRect

@export_enum("name", "values") var type = 0

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is Array and data.size() >= 2 and data[1] == type:
		return true
	return false

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is Array and data.size() >= 2 and data[0] is Node:
		var node: Control = data[0]
		node.get_parent().remove_child(node)
		add_child(node)
		node.position = at_position 
