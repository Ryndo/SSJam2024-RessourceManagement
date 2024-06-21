extends GameState

@export var label : Label

func _ready() :
	GameLoopSignals.RoundEnded.connect(EventAllTriggered)
	GameLoopSignals.EndRoundResult.connect(CloseRecap)
	
func UpdateDisplay() :
	label.text = "End of round " + str(GameProgression.CurrentWave) +"."
	
func EventAllTriggered() :
	GameLoopSignals.RoundFinishEventsResolved.emit()
	
func CloseRecap() :
	CloseScene()
