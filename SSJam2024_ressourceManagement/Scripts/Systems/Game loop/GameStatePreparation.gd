extends GameState


func ReadyForRound() :
	GameLoopSignals.ReadyForNextRound.emit()	
