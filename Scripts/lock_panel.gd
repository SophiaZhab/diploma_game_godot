extends Control

@export var library_scene_path := "res://scenes/library.tscn"

var correct_code = [1, 2, 1]
var current_code = [0, 0, 0]

func _ready():
	_update_display()
	
	Global.visited_library = true
	
	$Digit1.connect("pressed", Callable(self, "_on_digit_pressed").bind(0))
	$Digit2.connect("pressed", Callable(self, "_on_digit_pressed").bind(1))
	$Digit3.connect("pressed", Callable(self, "_on_digit_pressed").bind(2))
	
	if Inventory.items.has("note-code") and Inventory.items["note-code"] > 0:
		NarrationManager.show_lines([
			"Ось код.",
			"Це ж якась загадка. Чому не можна було просто написати число?",
			"Доведеться розгадати."
		])
		
		var puzzle_area = get_node("note-code")
		if puzzle_area:
			puzzle_area.visible = true
			
	else:
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
	if Inventory.items.has("note-code"):
		Inventory.items.erase("note-code")
	Global.puzzle_library_solved = true
	await get_tree().process_frame
	await get_tree().create_timer(0.3).timeout 
	get_tree().change_scene_to_file(library_scene_path)
	
func _enter_library():
	call_deferred("_change_scene", library_scene_path)
