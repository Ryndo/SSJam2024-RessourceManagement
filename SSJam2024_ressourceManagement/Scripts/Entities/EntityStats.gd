class_name EntityStats extends Node


@export var EntityType : GameData.EntityType
@export var AggroRange : float 
@export var AttackRange : float 
@export var MovementSpeed : float 
@export var AttackDamage : float
@export var AttackSpeed :float #attack per second
@export var Health : float
@export var MaxHealth : float
@export var LootType : GameData.LootType
@export var LootQuantity : int
@export var MinimumAggroRange : float 
@export var MinimumAttackRange : float 
@export var MinimumMovementSpeed : float 
@export var MinimumAttackDamage : float
@export var MinimumAttackSpeed :float #attack per second
@export var MinimumHealth : float
@export var MinimumMaxHealth : float

enum StatType {targetingRange,attackRange,moveSpeed,attackSpeed,attackDamage,health,maxHealth }
enum ModificationType {additive,multiplicative}

func UpdateStat(stat : StatType, value , modificationType : ModificationType) :
	match stat :
		StatType.targetingRange :
			if modificationType == ModificationType.additive :
				AggroRange += value
			else :
				AggroRange *= value
			AggroRange = max(AggroRange,MinimumAggroRange)
			
		StatType.attackRange :
			if modificationType == ModificationType.additive :
				AttackRange += value
			else :
				AttackRange *= value
			AttackRange = max(AttackRange,MinimumAttackRange)
			
		StatType.moveSpeed :
			if modificationType == ModificationType.additive :
				MovementSpeed += value
			else :
				MovementSpeed *= value
			MovementSpeed = max(MovementSpeed,MinimumMovementSpeed)
			
		StatType.attackSpeed :
			if modificationType == ModificationType.additive :
				AttackSpeed += value
			else :
				AttackSpeed *= value
			AttackSpeed = max(AttackSpeed,MinimumAttackSpeed)
			
		StatType.attackDamage :
			if modificationType == ModificationType.additive :
				AttackDamage += value
			else :
				AttackDamage *= value
			AttackDamage = max(AttackDamage,MinimumAttackDamage)
			
		StatType.health :
			if modificationType == ModificationType.additive :
				Health += value
			else :
				Health *= value
			Health = max(Health,MinimumHealth)
			
		StatType.maxHealth :
			if modificationType == ModificationType.additive :
				MaxHealth += value
			else :
				MaxHealth *= value
			MaxHealth = max(MaxHealth,MinimumMaxHealth)
			
		_ :
			return
