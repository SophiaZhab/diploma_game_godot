extends Area2D



func _on_body_entered(body):
	if body.name == "Player" and Global.is_table_solved:
		call_deferred("_change_to_generator_scene")

func _change_to_generator_scene():
	get_tree().change_scene_to_file("res://scenes/Generator.tscn")
	update_visibility() 


func _on_ready() -> void:
	update_visibility()

func update_visibility() -> void:
	$dbSp.visible = Global.generator_running
	$mathSp.visible = Global.generator_running
	$monitor.visible = Global.generator_running
