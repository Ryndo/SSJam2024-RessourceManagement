class_name TotemUpgrade extends Node

var isOnCooldown = false

func ApplyUpgrade(base : TotemBase) :
	base.Stats.AbilityRange += 35
	
func TriggerAbility(entities) :
	if isOnCooldown :
		return
	pass
