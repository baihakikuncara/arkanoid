extends Area2D


func _on_DeathZone_body_entered(body):
	if body.has_method("delete_ball"):
		body.delete_ball() 
