extends Node2D

class_name EntityCombat

@export var shapeRange : CollisionShape2D

var collider #character body
var isAttacking = false
var isInRangeOfTarget = false

var entitiesInArea : Array[Node2D]

signal isInRangeOfAttack(entity)
signal isOutofRangeOfAttack(entity)

func Setup(_collider, attackRange) :
	collider = _collider
	shapeRange.shape.radius = attackRange
	
func Attack(attackRange) :

	pass
	

func _on_area_2d_body_entered(body):
	if collider == body :
		return
	entitiesInArea.append(body)
	isInRangeOfAttack.emit(body)


func _on_area_2d_body_exited(body):
	if collider == body :
		return
	entitiesInArea.remove_at(entitiesInArea.find(body))
	isOutofRangeOfAttack.emit(body)

func IsInAttackRange(entity) :
	for _entity in entitiesInArea :
		if _entity == entity :
			return true
	return false
