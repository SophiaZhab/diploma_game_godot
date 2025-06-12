extends Area2D

@export var trigger_lines: Array[String] = [
	"Ти почув скрип підлоги під ногами.",
	"Навколо стало тихіше..."
]
@export var one_shot: bool = true
@export var trigger_id: String = "trigger_1" 

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		_trigger()

func _trigger() -> void:
	if one_shot and Global.triggered_dialogs.has(trigger_id):
		return 
	
	if has_node("/root/NarrationManager"):
		NarrationManager.show_lines(trigger_lines)
		
	if one_shot:
		Global.triggered_dialogs[trigger_id] = true
		queue_free()
