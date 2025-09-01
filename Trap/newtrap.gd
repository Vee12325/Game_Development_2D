extends Node2D

@export var arrow_scene: PackedScene
@export var shoot_interval: float = 2.0
@export var fire_dir: Vector2 = Vector2.RIGHT

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = shoot_interval
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)
	timer.timeout.connect(shoot)

func shoot() -> void:
	if arrow_scene:
		var arrow = arrow_scene.instantiate()
		get_parent().add_child(arrow)  # ยิงลูกศรออกไปใน world
		arrow.global_position = global_position
		arrow.fire(fire_dir)
