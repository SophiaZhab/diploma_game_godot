extends Area2D

@export var puzzle_scene := "res://scenes/Bookshelf.tscn"
@export var required_books: Array[String] = ["book1", "book2", "book3"]

func _ready():
	add_to_group("interactables")
	print("Shelf initialized: ", name)

func _on_body_entered(body):
	if body.name == "Player" or body.is_in_group("player"):
		if _has_required_books():
			_open_puzzle()
		else:
			_show_missing_books_message()

func _has_required_books() -> bool:
	for book in required_books:
		if not Inventory.items.has(book) or Inventory.items[book] <= 0:
			return false
	return true

func _open_puzzle():
	print("All required books are present. Opening puzzle.")
	call_deferred("_change_scene", puzzle_scene)

func _show_missing_books_message():
	print("Missing one or more required books.")
	NarrationManager.show_lines([
		"На цій полиці всі книги мають цифри і малюнок.",
		"Але схоже, що не вистачає декількох."
	])

func _change_scene(scene_path):
	get_tree().change_scene_to_file(scene_path)
