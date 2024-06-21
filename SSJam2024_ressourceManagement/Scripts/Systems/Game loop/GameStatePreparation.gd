extends GameState

@export var Inventory : Control
@export var Shop : Control
@export var SoulsInvetory : Control
@export var TotemExplanation : Control
@export var NextWaveInfos : Control
@export var BoosterOpening : Control
@export var ReadyButton : Control

func _ready():
	GameLoopSignals.EndPreparation.connect(EndPreparationPhase)
	GameLoopSignals.StartPreparation.connect(StartPreparation)
	
func ReadyForRound() :
	GameLoopSignals.ReadyForNextRound.emit()	

func EndPreparationPhase() :
	CloseScene()
	
func StartPreparation() :
	pass	
