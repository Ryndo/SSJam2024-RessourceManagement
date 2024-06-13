extends EntityCombat



func _on_attack_range_body_entered(body):
	if collider == body :
		return
	isInRangeOfAttack.emit(body)


func _on_attack_range_body_exited(body):
	if collider == body :
		return
	isOutofRangeOfAttack.emit(body)
