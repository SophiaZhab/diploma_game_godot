extends Area2D

@export var target_scene: String
@export var return_spawn_point_name: String = ""

func _ready():
	input_pickable = true

#func _input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#print("Changing scene to: ", target_scene)
		#Global.last_door_name = return_spawn_point_name
		#get_tree().change_scene_to_file(target_scene)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Changing scene to: ", target_scene)
		Global.last_door_name = return_spawn_point_name
		get_tree().change_scene_to_file(target_scene)
