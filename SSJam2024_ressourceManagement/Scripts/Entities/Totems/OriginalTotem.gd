class_name OriginalTotem extends Node

@export var Health : int

signal OriginalTotemIsDead

		
func TakeDamage(amount) :
	print(Health)
	Health -= amount
	if Health > 0 :
		return
	TotemIsDead()
	
	
func TotemIsDead() :
	OriginalTotemIsDead.emit()
	pass
