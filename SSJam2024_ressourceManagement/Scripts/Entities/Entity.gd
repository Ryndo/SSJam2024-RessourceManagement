extends Node3D

class_name Entity

@export var Stats : EntityStats
@export var Movement : EntityMovement
@export var Combat : EntityCombat
@export var Targeting : EntityTargeting
@export var PathFinding : EntityPathfinding

var disabled = true

signal entityDied(entity)

func _ready():
	pass
	
func Setup() :
	Movement.collider.disabled = false
	Targeting.Setup(Movement,Stats.AggroRange)
	Combat.Setup(Movement,Stats.AttackRange,Stats.AttackSpeed)
	Movement.Setup()

func Activate() :
	Targeting.Activate()
	Combat.Activate()
	Movement.Activate()
	disabled = false
	
func Disable() :
	disabled = true
	Targeting.Disable()
	Combat.Disable()
	Movement.Disable()
	
	

func _physics_process(delta):
	if disabled :
		return
		
	if Combat.IsInAttackRange(Targeting.currentTarget) :
		Combat.Attack(Targeting.currentTarget.get_parent(),Stats.AttackDamage)
		if Targeting.currentTarget != null and Targeting.currentTarget.get_parent().IsAlive :
			Movement.StopMoving()
			return
		DropTarget()
		return
	var nextPathPoint = PathFinding.GetNextPathPoint()
	if nextPathPoint == null : 
		Movement.Move(Movement.global_position,Stats.MovementSpeed)
		return
	Movement.Move(nextPathPoint,Stats.MovementSpeed)
	
func TargetingTargetChanged(oldTarget, newTarget) :
	if oldTarget != null :
		oldTarget.get_parent().entityDied.disconnect(DropTarget)
	if newTarget !=null and newTarget.get_parent() is Entity:
		newTarget.get_parent().entityDied.connect(DropTarget)
	PathFinding.SetTarget(newTarget)

func EntityInRangeOfAttack(entity):
	if entity == Targeting.currentTarget : 
		Combat.isAttacking = true
		Movement.StopMoving()
		
func OutOfAttackRange(entity):
	if Targeting.currentTarget != null and entity == Targeting.currentTarget : 
		ChaseTarget()

func ChaseTarget() :
	Combat.isAttacking = false

func OnDamageTaken(amount):
	Stats.Health -= amount
	OnHealthChanged()
	
func OnHealthChanged() :
	if !IsAlive() :
		KillEntity()

func KillEntity() :
	entityDied.emit(self)
	call_deferred("Disable")
	queue_free()

func IsAlive() :
	return Stats.Health > 0
	
func DropTarget(entity = null) :
	PathFinding.CancelPath()
	Movement.ForceStop()
	Targeting.DropCurrentTarget()
	Combat.isAttacking = false

func ApplyBuff(stat : EntityStats.StatType, value , modificationType : EntityStats.ModificationType) :
	Stats.UpdateStat(stat,value,modificationType)
