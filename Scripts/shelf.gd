extends Node2D

var correct_sequence = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var is_game_won = false

const SAVE_PATH = "user://puzzle_save.cfg"

func _save_game_state():
	var config = ConfigFile.new()
	config.set_value("puzzle", "is_solved", is_game_won)


func _load_game_state():
	var config = ConfigFile.new()
	
		
func _ready():
	randomize()
	_load_game_state()
	
	var book_slots = $BookShelf.get_children()
	var book_textures = []
	
	for book in book_slots:
		if book is BookItem and book.texture != null:
			book_textures.append(book.texture)

	book_textures.shuffle()
	
	var index = 0
	for book in book_slots:
		if book is BookItem and index < book_textures.size():
			book.texture = book_textures[index]
			index += 1

	for book in book_slots:
		if book is BookItem:
			book.connect("texture_changed", _check_win_condition)
			
	if is_game_won:
		_show_win_message()
		_lock_books()
		return

func _check_win_condition():
	if is_game_won:
		return
		
	var book_slots = $BookShelf.get_children()
	var current_sequence = []

	for book in book_slots:
		if book is BookItem and book.texture != null:
			var book_id = _get_book_id_from_texture(book.texture)
			current_sequence.append(book_id)

	if current_sequence.size() == correct_sequence.size():
		var is_correct = true
		for i in range(current_sequence.size()):
			if current_sequence[i] != correct_sequence[i]:
				is_correct = false
				break
		
		if is_correct:
			if is_correct:
				_save_game_state()
				NarrationManager.show_lines(["Хух, нарешті пройшов.",
				"Тепер з цими числами потрібно щось робити. ",
				"Напевно, слід запам'ятати"])
				print("ddd")
func _get_book_id_from_texture(texture):

	var texture_path = texture.resource_path

	var regex = RegEx.new()
	regex.compile("book_(\\d+)")
	var result = regex.search(texture_path)
	
	if result:
		return int(result.get_string(1))
	return -1

func _show_win_message():
	$WinMessage.visible = true

func _lock_books():
	var book_slots = $BookShelf.get_children()
	for book in book_slots:
		if book is BookItem:
			book.set_process(false)
