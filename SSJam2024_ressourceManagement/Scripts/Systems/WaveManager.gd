extends Node

@export var spawningArea : Node3D
@export var initialTotem : Node3D
@export var delayBetweenStep : Timer

var importedSpawnWaveInfos
var stepCounter = 0

var spawnedEnnemyAlive = 0
var ennemies : Array
var allEnnemiesSpawned = false

signal allEnnemiesAreDead

func _process(delta):
	if AllEnnemiesAreDead() :
		allEnnemiesAreDead.emit()
	
func _ready() :
	importedSpawnWaveInfos = DataFileAccesser.LoadFile(DataFileAccesser.GetWaveFilePath(0))
	if EntitySpawner.is_node_ready() :
		call_deferred("SpawnStep")
	else : 
		EntitySpawner.ready.connect(SpawnStep)
	#call_deferred("SetupEnnemies")
	
func SpawnWave(waveInfos) :
	for step in waveInfos :
		if step != null :
			for entity in step :
				var vector = str_to_var("Vector3" + entity[0]) as Vector3
				ennemies.append(EntitySpawner.get_node("Entity spawner").SpawnEntity(GameData.EntityType[entity[1]],vector,spawningArea))
				pass
				
func SetupEnnemies() :
	await get_tree().process_frame
	for ennemy in ennemies :
		ennemy.SetupTargetTotem(initialTotem)
		ennemy.Setup()
		ennemy.entityDied.connect(ReduceEnnemyAlive)

func SpawnStep() :
	ennemies.clear()
	if stepCounter >= importedSpawnWaveInfos.size() :
		allEnnemiesSpawned = true
		return
	var step = importedSpawnWaveInfos[stepCounter]
	if step == null :
		return
	for entity in step[0] :
		var vector = str_to_var("Vector3" + entity[0]) as Vector3
		ennemies.append(EntitySpawner.get_node("Entity spawner").SpawnEntity(GameData.EntityType[entity[1]],vector,spawningArea))
		spawnedEnnemyAlive += 1
		pass
	stepCounter += 1
	SetupEnnemies()
	delayBetweenStep.start(step[1])

func ReduceEnnemyAlive() :
	spawnedEnnemyAlive -= 1

func AllEnnemiesAreDead() :
	return IsAllSpawnedEnnemyDead() and allEnnemiesSpawned
	
func IsAllSpawnedEnnemyDead() :
	return spawnedEnnemyAlive == 0
