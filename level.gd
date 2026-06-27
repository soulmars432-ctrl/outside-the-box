extends Node2D
@onready var creeking_sound: AudioStreamPlayer = $"../creeking_sound"

@onready var progress_bar: ProgressBar = $"../ProgressBar"
@onready var timer = get_tree().create_timer(0.75)
# Called when the node enters the scene tree for the first time.
@onready var player: CharacterBody2D = $player
@onready var goal: Area2D = $goal

var cooldown = 1.0
var boxes_falling: int = 0

func set_box_falling(active: bool) -> void:
	if active:
		boxes_falling += 1
	else:
		boxes_falling = max(0, boxes_falling - 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.is_sliding or !boxes_falling == 0:
		progress_bar.value = 0.75
	else:
		progress_bar.value = timer.time_left
	if timer.time_left == 0:
		player.in_rotation = false
	else:
		player.in_rotation = true
	if timer.time_left == 0 and !player.is_sliding and boxes_falling == 0:
		
		var tween = get_tree().create_tween()
		tween.stop()
		if Input.is_action_just_pressed("ui_left"):
			
			tween.tween_property(self, "rotation_degrees", rotation_degrees-90, 0.75)
			creeking_sound.play()
			tween.play()
			timer = get_tree().create_timer(cooldown)
		if Input.is_action_just_pressed("ui_right"):
			
			tween.tween_property(self, "rotation_degrees", rotation_degrees+90, 0.75)
			creeking_sound.play()
			tween.play()
			timer = get_tree().create_timer(cooldown)
	
		
