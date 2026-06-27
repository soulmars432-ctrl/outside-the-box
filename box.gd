extends CharacterBody2D

@onready var player: CharacterBody2D = $"../player"
@onready var level: Node2D = $".."

var is_on_ground = true
var was_falling = false

func _physics_process(delta: float) -> void:
	var falling = not is_on_floor()
	if falling:
		if level:
			level.set_box_falling(true)
		if not was_falling:
			was_falling = true
		velocity += get_gravity() * delta
	else:
		if level:
			level.set_box_falling(false)
		if was_falling:
			was_falling = false
		is_on_ground = true
		
	move_and_slide()
