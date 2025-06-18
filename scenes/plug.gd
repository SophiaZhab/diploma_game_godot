extends Area2D

@export var socket_node: Area2D    

var dragging: bool = false
var snapped:  bool = false
var offset:   Vector2
var start_pos: Vector2

signal object_snapped

func _ready() -> void:
	
	input_pickable = true         
	start_pos      = global_position
	set_process(true)
	
	NarrationManager.show_lines([
			"Зараз я його увімкну.",
		])

func _input_event(_v, e: InputEvent, _i) -> void:
	if snapped:
		return

	if e is InputEventMouseButton \
	and e.button_index == MOUSE_BUTTON_LEFT \
	and e.pressed:
		dragging = true
		offset   = global_position - e.global_position
		z_index  = 10                 

func _process(_dt: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() + offset

		
		if !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			_stop_drag()
			return

		
		if socket_node and socket_node in get_overlapping_areas():
			_snap()

func _stop_drag() -> void:
	dragging = false
	z_index  = 0
	if !snapped:
		create_tween().tween_property(
			self, "global_position", start_pos, 0.25)

func _snap() -> void:
	snapped = true
	dragging = false
	z_index  = 0
	$CollisionShape2D.disabled = true   
	object_snapped.emit()
