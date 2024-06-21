extends Entity

var originalTotem : Node3D

func SetupTargetTotem(_originalTotem) :
	originalTotem = _originalTotem
	PathFinding.SetTarget(originalTotem)
	
func TargetingTargetChanged(oldTarget, newTarget) :
	if newTarget == null :
		super.TargetingTargetChanged(oldTarget,originalTotem)
		return
	super.TargetingTargetChanged(oldTarget,newTarget)

func EntityInRangeOfAttack(entity):
	var parent = entity.get_parent()
	if parent != null and parent is OriginalTotem :
		parent.TakeDamage(Stats.DamageToOriginalTotem)
		KillEntity()
	if entity == Targeting.currentTarget : 
		Combat.isAttacking = true
		Movement.StopMoving()
