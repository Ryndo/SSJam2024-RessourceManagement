extends Area2D

class_name EntityTargeting;

@export var rangeShape : CollisionShape2D
@export var resetTargetingTimer : Timer

var collider #character body
var entitiesInRange : Array[Node2D]
var currentTarget

var isTargetingOff = false
signal targetChanged(target)

func Setup(body,range) :
	collider = body
	rangeShape.shape.radius = range
	
func _process(delta):
	if isTargetingOff :
		return
	CalculateNewTarget()
	
func CalculateNewTarget() :
	var closestEntity
	for entity in entitiesInRange :
		if closestEntity == null or global_position.distance_to(entity.global_position) < global_position.distance_to(closestEntity.global_position) :
			closestEntity = entity
	if currentTarget == closestEntity :
		return
	print(closestEntity)
	currentTarget = closestEntity
	targetChanged.emit(currentTarget)

func _on_body_entered(body):
	if body == collider :
		return
	entitiesInRange.append(body)

func _on_body_exited(body):
	var index = entitiesInRange.find(body)
	if index == -1 :
		return
	entitiesInRange.remove_at(index)


func ResetTargeting() :
	currentTarget = null
	resetTargetingTimer.start()
	isTargetingOff = true


func TargetingResetTimerEnded():
	isTargetingOff = false
