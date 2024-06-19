extends GameState

func EventAllTriggered() :
	GameLoopSignals.EndRoundEventsResolved.emit()
	
