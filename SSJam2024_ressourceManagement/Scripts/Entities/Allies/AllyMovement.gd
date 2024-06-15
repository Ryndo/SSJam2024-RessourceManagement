extends EntityMovement

func AgentVelocityComputed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()
