extends CharacterBody2D

const SPEED = 1000.0
@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("player")
	print("Player initialized, checking for spawn position")
	await get_tree().process_frame
	_set_spawn_position()
	
func _set_spawn_position():
	if Global.last_door_name == "":
		print("No door name saved")
		return

	var doors = get_tree().get_nodes_in_group("doors")
	print("Found doors: ", doors.size())

	for door in doors:
		print("Checking door: ", door.name)
		if door.name == Global.last_door_name:
			print("Match! Spawning at door: ", door.name)
			position = door.global_position + Vector2(0, 0)
			break

	Global.last_door_name = ""


func _physics_process(_delta):
	if Global.is_dialog_active:
		velocity = Vector2.ZERO
		anim_sprite.play("stand")
		return

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
