extends CharacterBody2D


const SPEED = 200.0
#const JUMP_VELOCITY = -400.0


@onready var anim_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		anim_sprite.play("run_right")  # Запускаємо анімацію бігу праворуч
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		anim_sprite.play("run_left")  # Запускаємо анімацію бігу ліворуч
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		anim_sprite.play("run_forward")  # Анімація вниз
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		anim_sprite.play("run_back")  # Анімація вгору
	else:
		anim_sprite.play("stand")  # Якщо не рухаємось – анімація стояння

	velocity = direction.normalized() * SPEED
	move_and_slide()
