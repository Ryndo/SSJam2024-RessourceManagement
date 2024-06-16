@tool

extends EditorScript

@export var stepsPos : Array[Vector3]
@export var stepsEntity : Array[String]

var AllyEntity : PackedScene
var EnnemyEntity : PackedScene

var userChoices : Node
var json = JSON.new()
var path = "user://data.json"

func _run():
	userChoices = get_scene().get_node(".")
	path = "user://wave_" + str(userChoices.Wave) +".json"
	AllyEntity = preload("res://Prefabs/Entities/Ally.tscn")
	EnnemyEntity = preload("res://Prefabs/Entities/ennemy.tscn")
	var jsonContent = Load()
	var entitiesPlacements = WaveJsonTranslator.JsonToArray(json.data)
	if userChoices.Action == GameData.WaveEditorAction.Load :
		LoadEntityPosition(entitiesPlacements[userChoices.Step])
	else :
		save(entitiesPlacements,RegisterEntityPosition())
		
func RegisterEntityPosition() :
	var entitiesPlacement : Array
	var entities = get_scene().get_node("Spawner").get_children()
	stepsPos.resize(entities.size())
	stepsEntity.resize(entities.size())
	entitiesPlacement.resize(entities.size())
	for i in range(entities.size()) :
		var entity : Entity = entities[i]
		entitiesPlacement[i] = [entity.position,GameData.EntityType.find_key(entity.Stats.EntityType)]
	return entitiesPlacement
	
func save(array,waveStep) :
	var updatedArray = WaveJsonTranslator.ArrayToJson(waveStep,array,userChoices.Step)
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(updatedArray,"\t"))
	file.close()
	file = null
	
func Load() :
	var file
	if !FileAccess.file_exists(path) :
		file = FileAccess.open(path, FileAccess.WRITE)
	else :
		file = FileAccess.open(path, FileAccess.READ)
	var stringContent = file.get_file_as_string(path)
	return json.parse(stringContent)
	
func LoadEntityPosition(entitiesPlacements) :
	if entitiesPlacements == null :
		return
	var spawner = get_scene().get_node("Spawner")
	for node in spawner.get_children() :
		node.queue_free()
	for placement in entitiesPlacements :
		var vector = str_to_var("Vector3" + placement[0]) as Vector3
		SpawnEntity(GameData.EntityType[placement[1]],vector)
		pass
	


func SpawnEntity(entityType : GameData.EntityType ,position) :
	var spawnedEntity = PickEntityFromType(entityType).instantiate()
	get_scene().get_node("Spawner").add_child(spawnedEntity)
	spawnedEntity.set_owner(get_scene())
	spawnedEntity.position = position

func PickEntityFromType(type) :
	match type :
		GameData.EntityType.Ally :
			return AllyEntity
		GameData.EntityType.Ennemy :
			return EnnemyEntity
		_ :
			return null

	
