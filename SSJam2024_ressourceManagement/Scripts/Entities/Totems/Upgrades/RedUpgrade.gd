extends TotemUpgrade

func ApplyUpgrade(base : TotemBase) :
	base.Stats.AbilityRange += 5
	
func TriggerAbility(entities : Array[Entity]) :
	for entity in entities :
		entity.ApplyBuff(EntityStats.StatType.moveSpeed,-20,EntityStats.ModificationType.additive)
	pass
