extends Entity

@export var followRange : AllyFollowRange

var stopTargeting = false
func _ready():
	super._ready()
	followRange.Setup(Stats.FollowRange,global_position,Movement)
	
func _process(delta):
	if Input.is_action_just_pressed("MoveAlly") :
		PathFinding.CalculatePath(Movement.global_position,get_global_mouse_position())
		

func EnterFollowRange(entity):
	stopTargeting = false


func ExitFollowRange(entity):
	if Movement == entity :
		Combat.isAttacking = false
		Targeting.ResetTargeting()
		ReturnToHoldPosition()

func DropCurrentTarget() :
	Targeting.currentTarget = null
	
	
func TargetingTargetChanged(target) :
	if !followRange.IsInFollowRange(Movement) :
		DropCurrentTarget()
		return
	if target == null :
		ReturnToHoldPosition()
	super.TargetingTargetChanged(target)

func ReturnToHoldPosition() :
	PathFinding.CalculatePath(Movement.global_position,followRange.holdPosition)
