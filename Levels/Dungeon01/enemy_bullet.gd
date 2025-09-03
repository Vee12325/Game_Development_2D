extends Area2D

@export var speed: int = 300  # ความเร็วของกระสุน
@export var damage: int = 1  # ดาเมจของกระสุน
var direction: Vector2  # ทิศทางการยิง

@onready var sprite = $Sprite2D
@onready var hit_sound = $HitSound

func _ready() -> void:
	if sprite == null:
		print("❌ ไม่สามารถหา Sprite ได้!")

	direction = Vector2.RIGHT.rotated(rotation)
	
	if sprite != null:
		sprite.rotation = rotation

func _process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node) -> void:
	# เช็คว่าตัวที่ชนมีฟังก์ชัน _take_damage และมี HitBox
	if body.has_method("_take_damage") and body.has_node("HitBox"):
		var hurt_box = HurtBox.new()
		hurt_box.damage = damage  # ตั้งค่าดาเมจ

		# ส่ง HurtBox ไปยัง player เพื่อประมวลผลความเสียหาย
		body._take_damage(hurt_box)

		if hit_sound != null:
			hit_sound.play()
		else:
			print("❌ ไม่พบ HitSound!")

		queue_free()
