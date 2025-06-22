extends Area2D

func _ready() -> void:
	$StaticBody2D/CollisionShape2D.disabled = true
	$Sprite2D.visible = false

	if Global.is_table_solved:
		$StaticBody2D/CollisionShape2D.disabled = false
		$Sprite2D.visible = true
		
