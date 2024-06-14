extends CharacterBody2D

class_name EntityMovement

@export var Agent : NavigationAgent2D

var movementTreshold = .2

var timerStarted = false

func Move(nextPathPoint,speed) :
	var direction = global_position.direction_to(nextPathPoint)
	Agent.velocity = direction * speed
	
func StopMoving():
	Agent.set_velocity_forced(Vector2.ZERO)
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
