extends CharacterBody2D

const SPEED = 400.0
@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("player")
	print("Player initialized, checking for spawn position")
	
	await get_tree().process_frame
	
	if Global.last_door_name != "":
		print("Last door name: ", Global.last_door_name)
		var doors = get_tree().get_nodes_in_group("doors")
		print("Found doors: ", doors.size())
		
		for door in doors:
			print("Checking door: ", door.name)
			if door.name == Global.last_door_name:
				print("Door found! Setting position near: ", door.name)
				position = door.global_position + Vector2(150, 5)
				print("New player position: ", position)
				break
		
		Global.last_door_name = ""
	else:
		print("No door name saved")

func _physics_process(_delta):
	z_index = int(position.y)
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		anim_sprite.play("run_right")
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		anim_sprite.play("run_left")
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		anim_sprite.play("run_forward")
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		anim_sprite.play("run_back")
	else:
		anim_sprite.play("stand")
	
	velocity = direction.normalized() * SPEED
	move_and_slide()
