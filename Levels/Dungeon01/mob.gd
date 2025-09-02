extends StaticBody2D

@export var fireball_scene : PackedScene  # โหลด Scene กระสุน
@export var shooting_interval : float = 2.0  # เวลาระหว่างการยิง

var shoot_timer : float = 0.0  # ตัวจับเวลาสำหรับการยิง

@onready var sprite = $AnimatedSprite2D  # เอา AnimatedSprite2D มาเก็บไว้

func _ready() -> void:
	# เล่นอนิเมชัน
	sprite.play("dragon")
	shoot_timer = shooting_interval

func _process(delta: float) -> void:
	# ลดตัวจับเวลา
	shoot_timer -= delta
	if shoot_timer <= 0:
		shoot_fireball()  # ยิงกระสุน
		shoot_timer = shooting_interval  # รีเซ็ตตัวจับเวลา

# ฟังก์ชันยิงกระสุน
func shoot_fireball():
	if fireball_scene == null:
		print("Error: Fireball scene is not assigned!")  # หากยังไม่ได้กำหนดค่า fireball_scene
		return
	
	# สร้างกระสุนจาก Scene กระสุนที่เตรียมไว้
	var fireball = fireball_scene.instantiate()

	# ตั้งตำแหน่งเริ่มต้นของกระสุน (ตำแหน่งของมอนสเตอร์)
	fireball.position = position

	# คำนวณทิศทางการยิงจากการหมุนของมอนสเตอร์
	var fireball_direction = Vector2.RIGHT.rotated(rotation)  # หมุนตามมุมของมอนสเตอร์
	fireball.direction = fireball_direction  # กำหนดทิศทางของกระสุน

	# เพิ่มกระสุนไปใน Scene
	get_tree().current_scene.add_child(fireball)
