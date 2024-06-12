extends CharacterBody2D

class_name EntityMovement

@export var Raycasts : Node2D
@export var FrontRay : RayCast2D
@export var timer : Timer

var lastPosition 
var movementTreshold = .2

var timerStarted = false

func _ready():
	lastPosition = global_position

func Move(newVelocity) :
	velocity = newVelocity
	moveWithAvoidance()
	CheckMovement()
	
func moveWithAvoidance() :
	if velocity != Vector2.ZERO :
		Raycasts.rotation = velocity.angle()
		var obstacleAhead = ObstacleAhead()
		if obstacleAhead != null :
			var viableRay = GetViableRay()
			velocity = Vector2.RIGHT.rotated(Raycasts.rotation + viableRay.rotation) * velocity.length()
	move_and_slide()
	
func ObstacleAhead() :
	return FrontRay.get_collider()
	get_slide_collision_count()

func GetViableRay() :
	var raysAngle = 0
	for ray in Raycasts.get_children() :
		if !ray.is_colliding() :
			return ray
	return null

func CheckMovement() :
	if(global_position.distance_to(lastPosition) < movementTreshold)  :
		if !timerStarted :
			timerStarted = true
			timer.start()
	else :
		timerStarted = false
		timer.stop()
		set_collision_layer_value(1,false)
	lastPosition = global_position
	
func StopMoving():
	velocity = Vector2.ZERO
	
func _on_stationnary_timer_timeout():
	set_collision_layer_value(1,true)
