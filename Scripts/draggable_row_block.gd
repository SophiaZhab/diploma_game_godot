extends Control

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP

func _gui_input(event: InputEvent):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pass # get_drag_data буде викликаний автоматично

func get_drag_data(position: Vector2) -> Variant:
	var drag_data = {
		"type": "row_block",
		"node": self
	}
	
	var preview = self.duplicate()
	preview.modulate.a = 0.6
	set_drag_preview(preview)

	return drag_data
