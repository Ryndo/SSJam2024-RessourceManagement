extends Node

@export var entitySpawner : EntitySpawner
@export var spawningArea : Node3D
@export var initialTotem : Node3D
@export var delayBetweenStep : Timer
var importedSpawnWaveInfos
var stepCounter = 0

var ennemies : Array
func _ready() :
	importedSpawnWaveInfos = DataFileAccesser.LoadFile(DataFileAccesser.GetWaveFilePath(0))
	SpawnStep()
	#call_deferred("SetupEnnemies")
	
func SpawnWave(waveInfos) :
	for step in waveInfos :
		if step != null :
			for entity in step :
				var vector = str_to_var("Vector3" + entity[0]) as Vector3
				ennemies.append(entitySpawner.SpawnEntity(GameData.EntityType[entity[1]],vector,spawningArea))
				pass
				
func SetupEnnemies() :
	await get_tree().process_frame
	for ennemy in ennemies :
		ennemy.SetupTargetTotem(initialTotem)
		ennemy.Setup()

func SpawnStep() :
	ennemies.clear()
	if stepCounter >= importedSpawnWaveInfos.size() :
		return
	var step = importedSpawnWaveInfos[stepCounter]
	if step == null :
		return
	for entity in step[0] :
		print("e")
		var vector = str_to_var("Vector3" + entity[0]) as Vector3
		ennemies.append(entitySpawner.SpawnEntity(GameData.EntityType[entity[1]],vector,spawningArea))
		pass
	stepCounter += 1
	SetupEnnemies()
	delayBetweenStep.start(step[1])
