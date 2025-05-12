extends Area2D

@export var target_scene: String
@export var target_door_name: String = ""  

func _ready():
	add_to_group("doors")
	print("Door initialized: ", name)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player entered door: ", name)
		Global.last_door_name = target_door_name
		call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file(target_scene)
