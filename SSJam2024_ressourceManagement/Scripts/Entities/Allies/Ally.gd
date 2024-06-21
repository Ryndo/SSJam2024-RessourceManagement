class_name Ally extends Entity

@export var followRange : AllyFollowRange

var stopTargeting = false

func Setup():
	super.Setup()
	GameLoopSignals.StartNewRound.is_connected(Activate)
	#GameLoopSignals.EndRoundPhase.connect(Disable)
	followRange.Setup(Stats.FollowRange,global_position,Movement)
	
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
