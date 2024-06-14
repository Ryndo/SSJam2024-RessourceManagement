extends Node

class_name EntityPathfinding

@export var refreshTargetPathTimer : Timer
@export var Agent : NavigationAgent2D

var currentTarget

func SetTarget(target) :
	currentTarget = target
	
func CalculatePath() :
	Agent.target_position = currentTarget.global_position
	
func CalculatePathWithPosition(position) :
	Agent.target_position = position

func GetNextPathPoint() :
	if Agent.target_position == null :
		return null
	return Agent.get_next_path_position()
	
#on timer time out refresh path with new target position
func RefreshPath():
	if currentTarget == null :
		return
	CalculatePath()

func CancelPath() :
	currentTarget = null
