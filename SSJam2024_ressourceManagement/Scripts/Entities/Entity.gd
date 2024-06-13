extends Node2D

class_name Entity

@export var Stats : EntityStats
@export var Movement : EntityMovement
@export var Combat : EntityCombat
@export var Targeting : EntityTargeting
@export var PathFinding : EntityPathfinding
@export var Agent : NavigationAgent2D

func _ready():
	Targeting.Setup(Movement,Stats.AggroRange)
	Combat.Setup(Movement,Stats.AttackRange)

func _process(delta):
	if Input.is_action_just_pressed("MoveUnit") :
		PathFinding.CalculatePathWithPosition(get_global_mouse_position())
		
func _physics_process(delta):
	var nextPathPoint = PathFinding.GetNextPathPoint()
	if nextPathPoint == null :
		return
	if Combat.IsInAttackRange(Targeting.currentTarget) :
		return
	Movement.Move(nextPathPoint,Stats.MovementSpeed)
	
func TargetingTargetChanged(target) :
	PathFinding.SetTarget(target)

func EntityInRangeOfAttack(entity):
	if entity == Targeting.currentTarget : 
		Combat.isAttacking = true
		Movement.StopMoving()

func OutOfAttackRange(entity):
	if Targeting.currentTarget != null and entity == Targeting.currentTarget : 
		ChaseTarget()

func ChaseTarget() :
	Combat.isAttacking = false
