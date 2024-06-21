class_name WaveManager extends Node

@export var spawningArea : Node3D
@export var initialTotem : Node3D
@export var delayBetweenStep : Timer

var importedSpawnWaveInfos
var stepCounter = 0

var spawnedEnnemyAlive = 0
var ennemies : Array
var allEnnemiesSpawned = false

signal allEnnemiesAreDead

var roundStarted


func _process(delta):
	if !roundStarted :
		return
	if AllEnnemiesAreDead() and GameLoop.currentGameState == GameData.GameplayLoopState.Round :
		roundStarted = false
		allEnnemiesAreDead.emit()
	
func StartWaves(RoundNumber) :
	stepCounter = 0
	spawnedEnnemyAlive = 0
	allEnnemiesSpawned = false
	importedSpawnWaveInfos = DataFileAccesser.LoadFile(DataFileAccesser.GetWaveFilePath(RoundNumber))
	if EntitySpawner.is_node_ready() :
		call_deferred("SpawnStep")
	elif !EntitySpawner.ready.is_connected(SpawnStep) : 
		EntitySpawner.ready.connect(SpawnStep)
	roundStarted = true
	
func SetupEnnemies() :
	await get_tree().process_frame
	for ennemy in ennemies :
		ennemy.SetupTargetTotem(initialTotem)
		ennemy.Setup()
		ennemy.Activate()
		ennemy.entityDied.connect(ReduceEnnemyAlive)

func SpawnStep() :
	if !roundStarted or allEnnemiesSpawned :
		return 
	ennemies.clear()

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
	if stepCounter > importedSpawnWaveInfos.size() - 1 :
		allEnnemiesSpawned = true
		return

func ReduceEnnemyAlive(entity) :
	spawnedEnnemyAlive -= 1

func AllEnnemiesAreDead() :
	return IsAllSpawnedEnnemyDead() and allEnnemiesSpawned
	
func IsAllSpawnedEnnemyDead() :
	return spawnedEnnemyAlive == 0
