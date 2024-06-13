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
	
func EntityEnterAttackRange(body):
	if collider == body :
		return
	entitiesInArea.append(body)
	isInRangeOfAttack.emit(body)

func EntityExitAttackRange(body):
	if collider == body :
		return
	entitiesInArea.remove_at(entitiesInArea.find(body))
	isOutofRangeOfAttack.emit(body)

func IsInAttackRange(entity) :
	for _entity in entitiesInArea :
		if _entity == entity :
			return true
	return false
