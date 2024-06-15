extends Entity

@export var followRange : AllyFollowRange

var stopTargeting = false

func _ready():
	super._ready()
	followRange.Setup(Stats.FollowRange,global_position,Movement)
	
func _process(delta):
	if Input.is_action_just_pressed("MoveAlly") :
		var screenToWorld = get_viewport().get_camera_3d().project_position(get_viewport().get_mouse_position(),2000)
		var rayOrigin =  get_viewport().get_camera_3d().project_ray_origin(get_viewport().get_mouse_position())
		var rayEnd = rayOrigin + get_viewport().get_camera_3d().project_ray_normal(get_viewport().get_mouse_position()) * 2000
		var rayArray = get_world_3d().direct_space_state.intersect_ray((PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)))
		if rayArray.has("position") :
			PathFinding.CalculatePathWithPosition(rayArray["position"])

func EnterFollowRange(entity):
	stopTargeting = false

func ExitFollowRange(entity):
	if Movement == entity :
		Combat.isAttacking = false
		Targeting.ResetTargeting()
		ReturnToHoldPosition()

func DropCurrentTarget() :
	Targeting.currentTarget = null
	
func TargetingTargetChanged(oldTarget, newTarget) :
	if !followRange.IsInFollowRange(Movement) :
		DropCurrentTarget()
	if newTarget == null :
		super.TargetingTargetChanged(oldTarget,followRange)
		return
	super.TargetingTargetChanged(oldTarget,newTarget)

func ReturnToHoldPosition() :
	PathFinding.SetTarget(followRange)
