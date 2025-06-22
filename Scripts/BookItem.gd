
class_name BookItem
extends TextureRect

signal texture_changed

var original_texture = null

func _ready():
	original_texture = texture
	mouse_filter = Control.MOUSE_FILTER_PASS

func _get_drag_data(at_position):
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture
	preview_texture.expand_mode = 1
	preview_texture.size = size 
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	
	set_drag_preview(preview)
	
	var drag_data = {"original_texture": texture, "source_node": self}
	
	return drag_data
	
func _can_drop_data(_pos, data):
	return data is Dictionary and data.has("original_texture") and data["original_texture"] is Texture2D
	
func _drop_data(_pos, data):
	var source_texture = data["original_texture"]
	var source_node = data["source_node"]

	var current_texture = texture
	texture = source_texture
	source_node.texture = current_texture

	emit_signal("texture_changed")
	source_node.emit_signal("texture_changed")
