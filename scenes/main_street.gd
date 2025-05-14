extends Node2D

func _ready():
	if not NarrationManager.first_intro_shown:
		NarrationManager.first_intro_shown = true
		NarrationManager.show_lines([
			"Хух, нарешті дійшов.",
			"Ця жахлива негода застала мене у дорозі.",
			"О, і тут нікого. Схоже, це якась глобальна проблема."
		])
