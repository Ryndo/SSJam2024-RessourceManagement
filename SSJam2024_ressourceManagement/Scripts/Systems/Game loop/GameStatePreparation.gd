extends GameState

@export var inventory : Inventory
@export var shop : Shop
@export var soulsInvetory : SoulsUI
@export var roundPreview : NextRoundPreview

func _ready():
	GameLoopSignals.EndPreparation.connect(EndPreparationPhase)
	GameLoopSignals.StartPreparation.connect(StartPreparation)
	
func ReadyForRound() :

	GameLoopSignals.ReadyForNextRound.emit()	

func EndPreparationPhase() :
	CloseScene()
	
func StartPreparation() :
	shop.UpdateUI()
	inventory.Setup()
	soulsInvetory.UpdateDisplay()
	roundPreview.DisplayEnnemies()
	pass	
