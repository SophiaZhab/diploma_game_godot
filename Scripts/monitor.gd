extends Control

@onready var label1 = $LabelLine1
@onready var label2 = $LabelLine2
@onready var input_field = $HiddenLineEdit
@onready var way = $Way

var correct_line1 = "495877802"
var correct_line2 = "345430454"
var input1 := ""
var input2 := ""

func _ready():
	input_field.grab_focus()
	input_field.editable = false
	input_field.visible = false
	
	if Global.is_way_to_college_showed:
		way.visible = true
	
	if not Global.is_way_to_college_showed:
		NarrationManager.show_lines([
			"Може за допомогою цього я зможу знайти шлях до ППФК?",
		])

func _process(_delta):
	label1.text = format_code(input1)
	label2.text = format_code(input2)

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		var key := OS.get_keycode_string(event.keycode)
		if key.is_valid_int():
			if input1.length() < 9:
				input1 += key
			elif input2.length() < 9:
				input2 += key
			if input1.length() == 9 and input2.length() == 9:
				await get_tree().process_frame
				check_inputs()

		elif key == "Backspace":
			if input2.length() > 0:
				input2 = input2.left(input2.length() - 1)
			elif input1.length() > 0:
				input1 = input1.left(input1.length() - 1)

func check_inputs():
	if input1 == correct_line1 and input2 == correct_line2:
		go_to_next_scene()
		Global.is_way_to_college_showed = true
	else:
		reset_inputs()
		NarrationManager.show_lines([
			"Таких координат немає в базі.",
		])

func reset_inputs():
	input1 = ""
	input2 = ""

func go_to_next_scene():
	way.visible = true
	Global.is_way_to_college_showed = true

func format_code(raw_text: String) -> String:
	if raw_text.length() == 0:
		return ""
	
	var output := ""
	for i in raw_text.length():
		if i == 0:
			output += raw_text[i]
		elif i == 1:
			output += " " + raw_text[i]
		elif i == 2:
			output += "  " + raw_text[i]
		else:
			output += " " + raw_text[i]
	
	return output
