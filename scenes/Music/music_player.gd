extends Node2D

func _ready():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var vol = config.get_value("audio", "music_volume", 1.0)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(vol))

func linear2db(value: float) -> float:
	if value <= 0.0:
		return -80.0
	return 20.0 * (log(value) / log(10.0))
