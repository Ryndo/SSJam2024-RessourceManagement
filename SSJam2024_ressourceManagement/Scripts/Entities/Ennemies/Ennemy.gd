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
