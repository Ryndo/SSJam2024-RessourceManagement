extends Node3D

class_name Entity

@export var Stats : EntityStats
@export var Movement : EntityMovement
@export var Combat : EntityCombat
@export var Targeting : EntityTargeting
@export var PathFinding : EntityPathfinding

signal entityDied

func _ready():
	pass
	
func Setup() :
	Targeting.Setup(Movement,Stats.AggroRange)
	Combat.Setup(Movement,Stats.AttackRange,Stats.AttackSpeed)
	Movement.Setup()
	
func _process(delta):
	if Input.is_action_just_pressed("MoveUnit") :
		var rayOrigin =  get_viewport().get_camera_3d().project_ray_origin(get_viewport().get_mouse_position())
		var rayEnd = rayOrigin + get_viewport().get_camera_3d().project_ray_normal(get_viewport().get_mouse_position()) * 2000
		var rayArray = get_world_3d().direct_space_state.intersect_ray((PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)))
		if rayArray.has("position") :
			PathFinding.CalculatePathWithPosition(rayArray["position"])
		
func _physics_process(delta):
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
		entityDied.emit()
		KillEntity()

func KillEntity() :
	queue_free()

func IsAlive() :
	return Stats.Health > 0
	
func DropTarget() :
	PathFinding.CancelPath()
	Movement.ForceStop()
	Targeting.DropCurrentTarget()
	Combat.isAttacking = false
