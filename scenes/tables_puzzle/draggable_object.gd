extends TextureRect

func _get_drag_data(at_position: Vector2) -> Variant:
	var data = [self, 1]
	var prev = TextureRect.new()
	prev.texture = texture
	set_drag_preview(prev)
	
	
	return data
