extends Area2D

@export var target_scene: String = "res://scenes/Shop.tscn"

func _ready():
	add_to_group("doors")
	print("Shop door initialized: ", name)

func _on_body_entered(body: Node2D) -> void:
	print("Body entered shop door: ", body.name)
	if body.is_in_group("player"):
		print("Player entered shop door!")
		Global.last_door_name = name
		print("Set last_door_name to: ", name)
		call_deferred("_change_scene")
		
func _change_scene():
	print("Changing scene to shop")
	get_tree().change_scene_to_file(target_scene)
