extends Area2D

# ใช้ export เพื่อให้สามารถแก้ไขค่า points ได้ง่ายใน Inspector
@export var points = 10 

func _on_body_entered(body: Node2D):
	# ตรวจสอบว่าวัตถุที่ชนเป็นผู้เล่นหรือไม่
	if body.name == "Player":
		# เพิ่มคะแนนให้กับผู้เล่น
		# คุณอาจต้องสร้าง script ผู้เล่นและฟังก์ชันเพิ่มคะแนนก่อน
		# body.add_score(points)
		
		# ทำลายไอเทม
		queue_free()
