extends CharacterBody3D

class_name EntityMovement

@export var Agent : NavigationAgent3D
@export var collider : CollisionShape3D

func Setup() :
	collider.disabled = false
	Agent.avoidance_enabled = true
	set_physics_process(true)
	
func Disable() :
	set_physics_process(false)
	collider.disabled = true
	Agent.avoidance_enabled = false
	Agent.velocity = Vector3.ZERO
	velocity = Vector3.ZERO
	
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
