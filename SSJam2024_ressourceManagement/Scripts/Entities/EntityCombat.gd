extends Node2D

class_name EntityCombat

@export var shapeRange : CollisionShape2D

var collider #character body
var isAttacking = false

signal isInRangeOfAttack(entity)

func Setup(_collider, attackRange) :
	collider = _collider
	shapeRange.shape.radius = attackRange
	
func Attack(attackRange) :

	pass
	


func _on_area_2d_body_entered(body):
	if collider == body :
		return
	isInRangeOfAttack.emit(body)
