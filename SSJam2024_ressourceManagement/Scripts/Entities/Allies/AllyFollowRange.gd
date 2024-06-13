extends Area2D

class_name AllyFollowRange

@export var FollowArea : CollisionShape2D

var holdPosition 
var collider

signal EnterFollowRange(entity)
signal ExitFollowRange(entity)

var entitiesInArea : Array[Node2D]

func Setup(followRange,positionToHold,ally) :
	collider = ally
	FollowArea.shape.radius = followRange
	holdPosition = positionToHold

func _on_body_entered(body):
	entitiesInArea.append(body)
	if collider == body :
		return
	EnterFollowRange.emit(body)

func _on_body_exited(body):
	entitiesInArea.remove_at(entitiesInArea.find(body))
	ExitFollowRange.emit(body)

func IsInFollowRange(entity) :
	for body in entitiesInArea :
		if body == entity :
			return true
	return false


