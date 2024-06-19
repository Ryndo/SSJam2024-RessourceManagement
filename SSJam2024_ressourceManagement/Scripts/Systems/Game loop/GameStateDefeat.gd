extends GameState

func StartNewGame() :
	GameLoopSignals.StartNewGame.emit()

func ReturnToMenu() :
	GameLoopSignals.GoToMainMenu.emit()
