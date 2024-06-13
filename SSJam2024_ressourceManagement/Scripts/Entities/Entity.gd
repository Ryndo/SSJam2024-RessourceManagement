extends Node2D

class_name Entity

@export var Stats : EntityStats
@export var Movement : EntityMovement
@export var Combat : EntityCombat
@export var Targeting : EntityTargeting
@export var PathFinding : EntityPathfinding


func _ready():
	Targeting.Setup(Movement,Stats.AggroRange)
	Combat.Setup(Movement,Stats.AttackRange)

func _process(delta):
	if Input.is_action_just_pressed("MoveUnit") :
		PathFinding.CalculatePath(Movement.global_position,get_global_mouse_position())
		
func _physics_process(delta):
	if Combat.isAttacking :
		return
	if Targeting.currentTarget != null and !Combat.IsInAttackRange(Targeting.currentTarget) :
		ChaseTarget()
	var newVelocity = CalculateNewVelocity()
	Movement.Move(newVelocity)

func CalculateNewVelocity() :
	var newVelocity = Vector2.ZERO
	if !PathFinding.IsPathEmpty() :
		var nextPathPoint = PathFinding.GetNextPathPoint()
		if PathFinding.IsCloseEnough(Movement.global_position) :
			PathFinding.RemoveNextPathPoint()
			if !PathFinding.IsPathEmpty() :
				nextPathPoint = PathFinding.GetNextPathPoint()
				newVelocity = Movement.global_position.direction_to(nextPathPoint) * Stats.MovementSpeed
		else :
			newVelocity = Movement.global_position.direction_to(nextPathPoint) * Stats.MovementSpeed
	return newVelocity

func TargetingTargetChanged(target) :
	if target == null :
		return
	PathFinding.CalculatePath(Movement.global_position,target.global_position)


func EntityInRangeOfAttack(entity):
	if entity == Targeting.currentTarget : 
		Combat.isAttacking = true
		Movement.StopMoving()


func OutOfAttackRange(entity):
	print("out of attack range")
	if Targeting.currentTarget != null and entity == Targeting.currentTarget : 
		ChaseTarget()

func ChaseTarget() :
	Combat.isAttacking = false
	PathFinding.CalculatePath(Movement.global_position,Targeting.currentTarget.global_position)
