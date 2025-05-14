extends TextureRect

func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(30, 30)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	
	# Store original texture in drag data instead of nullifying it
	var drag_data = {"original_texture": texture, "source_node": self}
	
	return drag_data
	
func _can_drop_data(_pos, data):
	# Check if the drag data contains texture information
	return data is Dictionary and data.has("original_texture") and data["original_texture"] is Texture2D
	
func _drop_data(_pos, data):
	# Get the source texture and node
	var source_texture = data["original_texture"]
	var source_node = data["source_node"]
	
	# Store our current texture
	var current_texture = texture
	
	# Set our texture to the source texture
	texture = source_texture
	
	# Set the source node's texture to our original texture
	source_node.texture = current_texture
