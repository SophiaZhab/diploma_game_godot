extends Control

@export var library_scene_path := "res://scenes/library.tscn"

var correct_code = [1, 2, 1]
var current_code = [0, 0, 0]

func _ready():
	_update_display()
	
	$Digit1.connect("pressed", Callable(self, "_on_digit_pressed").bind(0))
	$Digit2.connect("pressed", Callable(self, "_on_digit_pressed").bind(1))
	$Digit3.connect("pressed", Callable(self, "_on_digit_pressed").bind(2))
	NarrationManager.show_lines([
			"Замок. Я маю відшукати код.",
			"Або принаймні того, хто його знає."
		])

func _on_digit_pressed(index):
	current_code[index] = (current_code[index] + 1) % 10
	_update_display()
	_check_code()

func _update_display():
	$Digit1.text = str(current_code[0])
	$Digit2.text = str(current_code[1])
	$Digit3.text = str(current_code[2])

func _check_code():
	print("→ Поточний код: ", current_code)
	if current_code == correct_code:
		_unlock()

func _unlock():
	NarrationManager.show_lines([
			"Замок відкрито."
		])
	Global.puzzle_library_solved = true
	await get_tree().process_frame
	await get_tree().create_timer(0.3).timeout 
	get_tree().change_scene_to_file(library_scene_path)
	
func _enter_library():
	call_deferred("_change_scene", library_scene_path)
