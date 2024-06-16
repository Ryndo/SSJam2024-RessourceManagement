extends CharacterBody3D

class_name EntityMovement

@export var Agent : NavigationAgent3D
@export var collider : CollisionShape3D
var timerStarted = false

func Setup() :
	collider.disabled = false
	
func Move(nextPathPoint,speed) :
	var direction = global_position.direction_to(nextPathPoint)
	Agent.velocity = direction * speed
	
func StopMoving():
	Agent.velocity  = Vector3.ZERO

func ForceStop() :
	Agent.set_velocity_forced(Vector3.ZERO)
	Agent.velocity = Vector3.ZERO
	
func AgentVelocityComputed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
