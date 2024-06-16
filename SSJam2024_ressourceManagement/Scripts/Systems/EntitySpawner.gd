class_name EntitySpawner extends Node

@export var AllyEntity : PackedScene
@export var EnnemyEntity : PackedScene
@export var pos : Node3D




func SpawnEntity(entityType : GameData.EntityType ,position) :
	var spawnedAlly = EnnemyEntity.instantiate()
	add_child(spawnedAlly)
	spawnedAlly.global_position = pos.global_position

func PickEntityFromType(type) :
	match type :
		GameData.EntityType.Ally :
			return AllyEntity
		GameData.EntityType.Ennemy :
			return EnnemyEntity
		_ :
			return null

