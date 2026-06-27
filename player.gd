extends CharacterBody2D

const SPEED = 1700.0

# Direction the character is currently sliding in
var slide_direction: Vector2 = Vector2.ZERO
@onready var whoosh: AudioStreamPlayer = $whoosh

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var level: Node2D = $".."

var is_sliding:bool = false
var in_rotation:bool = false


func _physics_process(delta: float) -> void:
	# Keep the player oriented with the dash direction while the level rotates.

	# Only accept new input when not already sliding
	if not is_sliding and not in_rotation:
		var input = Vector2.ZERO

		if Input.is_action_just_pressed("d"):
			input = Vector2.RIGHT
		elif Input.is_action_just_pressed("a"):
			input = Vector2.LEFT
		elif Input.is_action_just_pressed("s"):
			input = Vector2.DOWN
		elif Input.is_action_just_pressed("w"):
			input = Vector2.UP

		if input != Vector2.ZERO:
			slide_direction = input
			whoosh.play()
			is_sliding = true
			
	if is_sliding:
		velocity = slide_direction * SPEED
		move_and_slide()

		# Stop when we hit a wall in the direction we're moving
		if is_on_wall() or is_on_ceiling() or is_on_floor():
			# Check if we actually collided in our movement direction
			for i in get_slide_collision_count():
				var collision = get_slide_collision(i)
				var normal = collision.get_normal()
				# The wall normal opposes our direction → we hit a wall ahead
				if normal.dot(slide_direction) < -0.5:
					velocity = Vector2.ZERO
					is_sliding = false
					break
