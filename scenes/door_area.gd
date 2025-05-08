extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("Вхід у зону: ", body.name)
	if body.is_in_group("player"):
		print("Гравець зайшов у двері")
		get_tree().change_scene_to_file("res://scenes/Shop.tscn")
