class_name State_Bow extends State

const ARROW = preload("res://Interactables/arrow/arrow.tscn")

@onready var idle: State = $"../Idle"

var direction : Vector2 = Vector2.ZERO
var next_state : State = null

func enter() -> void:
	player.update_animation("bow")
	direction = player.cardinal_direction
	
	# เริ่ม loop ยิง
	_schedule_next_shot()

func exit() -> void:
	next_state = null
	pass

func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	return next_state

func physics(_delta: float) -> State:
	return null

func handle_input(_event: InputEvent) -> State:
	return null

# =========================
# ยิงลูกธนูอัตโนมัติ
# =========================
func _schedule_next_shot() -> void:
	var delay = randf_range(10.0, 15.0) # สุ่มเวลาระหว่าง 10–15 วิ
	get_tree().create_timer(delay).timeout.connect(_fire_arrow)

func _fire_arrow() -> void:
	direction = player.cardinal_direction

	var arrow: Arrow = ARROW.instantiate()
	player.add_sibling(arrow)
	arrow.global_position = player.global_position + (direction * 32)
	arrow.fire(direction)

	# ยิงเสร็จ ตั้งเวลารอบใหม่
	_schedule_next_shot()
