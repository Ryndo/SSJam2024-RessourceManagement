extends CharacterBody2D

class_name EntityMovement

@export var Raycasts : Node2D
@export var FrontRay : RayCast2D
@export var timer : Timer
@export var Agent : NavigationAgent2D

var lastPosition 
var movementTreshold = .2

var timerStarted = false

func _ready():
	lastPosition = global_position

func Move(nextPathPoint,speed) :
	var direction = global_position.direction_to(nextPathPoint)
	Agent.velocity = direction * speed
	
func StopMoving():
	Agent.velocity = Vector2.ZERO
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
