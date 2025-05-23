extends Node2D

@onready var college_barrier = $pinkBuid2/Collegebarrier
func _ready():
	if not NarrationManager.first_intro_shown:
		NarrationManager.first_intro_shown = true
		NarrationManager.show_lines([
			"Хух, нарешті дійшов.",
			"Ця жахлива негода застала мене у дорозі.",
			"О, і тут нікого. Схоже, це якась глобальна проблема."
		])
	if Global.is_way_to_college_showed:
		college_barrier.disabled = true
		
