extends Area2D

@export var target_scene: String = "res://scenes/main_street.tscn"
@export var target_door_name: String = "ShopDoor" 

func _ready():
	add_to_group("doors")
	print("Exit door initialized: ", name)

func _on_body_entered(body: Node2D) -> void:
	print("Body entered exit door: ", body.name)
	if body.is_in_group("player"):
		print("Player entered exit door!")
		Global.last_door_name = target_door_name
		print("Set last_door_name to: ", target_door_name)
		call_deferred("_change_scene")
		
func _change_scene():
	print("Changing scene to main street")
	get_tree().change_scene_to_file(target_scene)
