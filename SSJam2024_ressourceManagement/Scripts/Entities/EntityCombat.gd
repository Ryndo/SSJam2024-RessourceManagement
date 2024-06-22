extends Node3D

class_name EntityCombat

@export var shapeRange : CollisionShape3D
@export var attackCooldown : Timer

var collider #character body
var isAttacking = false
var isInRangeOfTarget = false

var entitiesInArea : Array[Node3D]

signal isInRangeOfAttack(entity)
signal isOutofRangeOfAttack(entity)
signal takeDamage(amount)

func Setup(_collider, attackRange, attackSpeed) :
	collider = _collider
	shapeRange.shape.radius = attackRange
	SetAttackSpeed(attackSpeed)
	
	
func Activate() :
	shapeRange.disabled = false
	
func Disable() :
	shapeRange.disabled = true
	entitiesInArea.clear()
	isAttacking = false
	isInRangeOfTarget = false
	attackCooldown.stop()
	
func Attack(target : Entity, attackDamage) :
	if !IsInAttackRange(target.Movement) :
		return
	if attackCooldown.is_stopped() :
		attackCooldown.start()
		target.Combat.ReceiveAttack(attackDamage)
	pass
	
func EntityEnterAttackRange(body):
	if collider == body :
		return
	entitiesInArea.append(body)
	isInRangeOfAttack.emit(body)
	

func EntityExitAttackRange(body):
	if collider == body :
		return
	if entitiesInArea.has(body) :
		entitiesInArea.remove_at(entitiesInArea.find(body))
	isOutofRangeOfAttack.emit(body)
	
func IsInAttackRange(entity) :
	for _entity in entitiesInArea :
		if _entity == entity :
			return true
	return false

func ReceiveAttack(damageAmount) :
	#Calculate damage reduction
	takeDamage.emit(damageAmount)
	
func SetAttackSpeed(attackSpeed) :
	attackCooldown.wait_time = 1 / attackSpeed
