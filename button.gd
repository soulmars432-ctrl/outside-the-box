extends Area2D


@export var door:StaticBody2D



var char_count: int = 0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("chars"):
		char_count += 1
		if char_count == 1:
			door.open()

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("chars"):
		char_count = max(char_count - 1, 0)
		if char_count == 0:
			door.close()
