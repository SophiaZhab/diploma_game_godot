extends Area2D

func _on_ready() -> void:
	
	if Global.is_table_solved:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
		
func _on_body_entered(body):
	if body.name == "Player" and Global.is_table_solved:
		get_tree().change_scene_to_file("res://scenes/Generator.tscn")
