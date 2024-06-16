extends Area3D

class_name EntityTargeting;

@export var rangeShape : CollisionShape3D
@export var resetTargetingTimer : Timer

var collider #character body
var entitiesInRange : Array[Node3D]
var currentTarget

var isTargetingOff = false
signal targetChanged(oldTarget, newTarget)

func Setup(body,range) :
	print(rangeShape)
	collider = body
	rangeShape.shape.radius = range
	
func _process(delta):
	if isTargetingOff :
		return
	CalculateNewTarget()
	
func CalculateNewTarget() :
	var oldTarget = currentTarget
	var closestEntity
	for entity in entitiesInRange :
		if closestEntity == null or global_position.distance_to(entity.global_position) < global_position.distance_to(closestEntity.global_position) :
			closestEntity = entity
	if currentTarget == closestEntity :
		return
	currentTarget = closestEntity
	targetChanged.emit(oldTarget,currentTarget)

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
	targetChanged.emit(currentTarget, null)
	currentTarget = null
	resetTargetingTimer.start()
	isTargetingOff = true
	
func DropCurrentTarget() :
	targetChanged.emit(currentTarget,null)
	currentTarget = null
	
	
func TargetingResetTimerEnded():
	isTargetingOff = false
