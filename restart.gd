extends Button

@onready var reset_sound: AudioStreamPlayer = $"../reset_sound"



func _on_pressed() -> void:
	reset_sound.play()
	await reset_sound.finished
	get_tree().reload_current_scene()
