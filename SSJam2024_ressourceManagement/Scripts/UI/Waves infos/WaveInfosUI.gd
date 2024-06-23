class_name NextRoundPreview extends Control

@export var ennemiesUI : Array[EnnemyInfoUI]

func _ready():
	DisplayEnnemies()
	
func DisplayEnnemies() :
	var ennemies = GameWavesinfos.GetNextRoundEnnemies()
	var counter = 0
	for ennemyType in ennemies :
		var icon = EntityTypeToAsset.GetAsset(ennemyType).Icon
		var quantity = ennemies[ennemyType]
		ennemiesUI[counter].UpdateDisplay(icon,quantity)
		counter += 1
	if counter >= ennemiesUI.size() :
		return
	for index in range(ennemiesUI.size() - counter) :
		ennemiesUI[index + counter].Hide()
