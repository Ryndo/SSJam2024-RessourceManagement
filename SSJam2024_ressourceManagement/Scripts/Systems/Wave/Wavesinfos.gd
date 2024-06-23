extends Node

func _ready():
	GetNextRoundEnnemies()
	
func GetRoundInfos(roundNumber) :
	return DataFileAccesser.LoadFile(DataFileAccesser.GetWaveFilePath(roundNumber))
	
func GetNextRoundEnnemies() :
	var infos = GetRoundInfos(GameProgression.CurrentWave)
	var ennemies = {}
	for step in infos :
		for placement in step[0] :
			if ennemies.has(GameData.EntityType[placement[1]]) :
				ennemies[GameData.EntityType[placement[1]]] += 1
			else :
				ennemies[GameData.EntityType[placement[1]]] = 1
	return ennemies
