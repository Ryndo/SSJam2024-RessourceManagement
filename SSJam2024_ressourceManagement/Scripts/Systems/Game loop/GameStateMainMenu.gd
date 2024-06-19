extends GameState


func StartNewGame() :
	GameLoopSignals.StartNewGame.emit()
	
	
func QuitGame() :
	GameLoopSignals.QuitTheGame.emit()
