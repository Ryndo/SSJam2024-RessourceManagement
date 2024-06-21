class_name EntityStats extends Node


@export var EntityType : GameData.EntityType
@export var AggroRange : float 
@export var AttackRange : float 
@export var MovementSpeed : float 
@export var AttackDamage : float
@export var AttackSpeed :float #attack per second
@export var Health : float
@export var MaxHealth : float

enum StatType {targetingRange,attackRange,moveSpeed,attackSpeed,attackDamage,health,maxHealth }

enum ModificationType {additive,multiplicative}

func UpdateStat(stat : StatType, value , modificationType : ModificationType) :
	match stat :
		StatType.targetingRange :
			if modificationType == ModificationType.additive :
				AggroRange += value
			else :
				AggroRange *= value
		StatType.attackRange :
			if modificationType == ModificationType.additive :
				AttackRange += value
			else :
				AttackRange *= value
		StatType.moveSpeed :
			if modificationType == ModificationType.additive :
				MovementSpeed += value
			else :
				AggroRange *= value
		StatType.attackSpeed :
			if modificationType == ModificationType.additive :
				AttackSpeed += value
			else :
				AttackSpeed *= value
		StatType.attackDamage :
			if modificationType == ModificationType.additive :
				AttackDamage += value
			else :
				AttackDamage *= value
		StatType.health :
			if modificationType == ModificationType.additive :
				Health += value
			else :
				Health *= value
		StatType.maxHealth :
			if modificationType == ModificationType.additive :
				MaxHealth += value
			else :
				MaxHealth *= value
		_ :
			return
