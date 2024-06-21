extends Node3D

@export var AllyEntity : PackedScene
@export var EnnemyEntity : PackedScene

var importedSpawnWaveInfos
var counter = 0
func SpawnEntity(entityType : GameData.EntityType ,position,nodeReceiver) :
	var spawnedEntity = PickEntityFromType(entityType).instantiate()
	spawnedEntity.name = str(GameData.EntityType.find_key(entityType)) + str(counter)
	get_node("/root/EntitiesScene").add_child(spawnedEntity)
	spawnedEntity.set_owner(get_node("/root/EntitiesScene"))
	spawnedEntity.position = position
	counter += 1
	return spawnedEntity

func PickEntityFromType(type) :
	match type :
		GameData.EntityType.Ally :
			return AllyEntity
		GameData.EntityType.Ennemy :
			return EnnemyEntity
		_ :
			return null


