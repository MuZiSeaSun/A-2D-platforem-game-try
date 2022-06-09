extends Area2D

signal hit

func _on_HitBox_area_entered(hurt_box):
	emit_signal("hit")
	hurt_box.emit_signal("hurt")
	pass # Replace with function body.
