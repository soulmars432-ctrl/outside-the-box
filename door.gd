extends StaticBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	close()

func open() -> void:
	sprite.frame = 1
	collision.set_deferred("disabled", true)

func close() -> void:
	sprite.frame = 0
	collision.set_deferred("disabled", false)
	
