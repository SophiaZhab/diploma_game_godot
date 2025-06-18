extends Area2D

func _on_ready() -> void:
	
	if Global.is_table_solved:
		$StaticBody2D/CollisionShape2D.disabled = false
		$Sprite2D.visible = true
	else:
		$StaticBody2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
