extends StaticBody2D



func _on_ready() -> void:
	if Global.puzzle_library_solved:
		$CollisionShape2D2.disabled = true
		
	if Global.is_way_to_college_showed and Global.dialogs_played.has("se_specialist_intro"):
		$CollisionShape2D2.disabled = false
	
	if Global.is_table_solved:
		$CollisionShape2D2.disabled = true
