class_name EntitySpawner extends Node3D

@export var AllyEntity : PackedScene
@export var EnnemyEntity : PackedScene

var importedSpawnWaveInfos

func _ready():
	pass
	
func SpawnEntity(entityType : GameData.EntityType ,position,nodeReceiver) :
	var spawnedEntity = PickEntityFromType(entityType).instantiate()
	nodeReceiver.add_child(spawnedEntity)
	spawnedEntity.set_owner(nodeReceiver)
	spawnedEntity.position = position
	return spawnedEntity

func PickEntityFromType(type) :
	match type :
		GameData.EntityType.Ally :
			return AllyEntity
		GameData.EntityType.Ennemy :
			return EnnemyEntity
		_ :
			return null

