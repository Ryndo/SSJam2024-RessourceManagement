extends Entity

func _process(delta):
	CalculateNextPosition(delta)
	
	
func CalculateNextPosition(delta) :
	var movementAmount = Movement.CalculateMovement(Stats.MovementSpeed * delta) 
	progress += movementAmount
