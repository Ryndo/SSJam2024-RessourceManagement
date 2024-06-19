extends Entity

var InitialTotem : Node3D

func SetupTargetTotem(initialTotem) :
	InitialTotem = initialTotem
	PathFinding.SetTarget(initialTotem)
	
func TargetingTargetChanged(oldTarget, newTarget) :
	if newTarget == null :
		super.TargetingTargetChanged(oldTarget,InitialTotem)
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
