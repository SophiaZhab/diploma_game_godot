extends Node2D

@onready var college_barrier = $pinkBuid2/Collegebarrier

func _ready():
	Global.footstep_type = "outdoor" 
	if not NarrationManager.first_intro_shown:
		NarrationManager.first_intro_shown = true
		
	if Global.is_way_to_college_showed:
		college_barrier.disabled = true
		
