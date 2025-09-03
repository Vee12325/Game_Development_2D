extends Area2D

# สัญญาณ (Signal) ที่จะส่งเมื่อไอเทมถูกเก็บ
signal item_collected

# เมื่อมีวัตถุเข้ามาชน
func _on_body_entered(body):
	# ถ้าวัตถุที่ชนคือ Player
	if body.is_in_group("player"):
		# ลบตัวเองออกจากฉาก
		queue_free()
