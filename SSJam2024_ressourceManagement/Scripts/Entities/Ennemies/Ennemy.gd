extends Entity

func _process(delta):
	
	super._process(delta)
	

func _physics_process(delta):
	#if Combat.isAttacking :
		#return
	var newVelocity = CalculateNewVelocity()
	Movement.Move(newVelocity)

func _on_entity_targeting_target_changed(target) :
	return
	if target == null :
		return
	PathFinding.CalculatePath(Movement.global_position,target.global_position)
