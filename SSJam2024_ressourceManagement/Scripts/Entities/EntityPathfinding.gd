extends Node

class_name EntityPathfinding

@export var refreshTargetPathTimer : Timer
@export var Agent : NavigationAgent3D

var currentTarget
var pathCancelled = false

func SetTarget(target) :
	currentTarget = target
	
func CalculatePath() :
	pathCancelled = false
	Agent.target_position = currentTarget.global_position
	
func CalculatePathWithPosition(position) :
	currentTarget = null
	Agent.target_position = position
	pathCancelled = false

func GetNextPathPoint() :
	if Agent.target_position == null or pathCancelled:
		return null
	return Agent.get_next_path_position()
	
#on timer time out refresh path with new target position
func RefreshPath():
	if currentTarget == null :
		return
	CalculatePath()

func CancelPath() :
	currentTarget = null
	pathCancelled = true
