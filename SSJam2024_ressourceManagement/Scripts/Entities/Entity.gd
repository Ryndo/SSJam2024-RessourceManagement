extends Node2D

class_name Entity

@export var Stats : EntityStats
@export var Movement : EntityMovement
@export var Combat : EntityCombat
@export var Targeting : EntityTargeting
@export var PathFinding : EntityPathfinding

@export var navigation2D : NavigationServer

func _ready():
	Targeting.Setup(Movement,Stats.AggroRange)
	Combat.Setup(Movement,Stats.AttackRange)
	pass
func _process(delta):
	if Input.is_action_just_pressed("MoveUnit") :
		PathFinding.CalculatePath(Movement.global_position,get_global_mouse_position())
		
func _physics_process(delta):
	if Combat.isAttacking :
		return
	var newVelocity = CalculateNewVelocity(delta)
	Movement.Move(newVelocity)

func CalculateNewVelocity(delta) :
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

func _on_entity_targeting_target_changed(target) :
	if target == null :
		return
	PathFinding.CalculatePath(Movement.global_position,target.global_position)


func _on_entity_combat_is_in_range_of_attack(entity):
	print(str(entity.name) + " in range")
	if entity == Targeting.currentTarget : 
		Combat.isAttacking = true
		Movement.StopMoving()
