extends GameState

func _ready():
	GameLoopSignals.EndDefeat.connect(CloseScene)

func StartNewGame() :
	GameLoopSignals.StartNewGame.emit()

func ReturnToMenu() :
	GameLoopSignals.GoToMainMenu.emit()
