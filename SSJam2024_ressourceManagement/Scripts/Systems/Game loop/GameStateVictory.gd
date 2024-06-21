extends GameState

func _ready():
	GameLoopSignals.EndVictory.connect(EndVictoryScreen)

func StartNewGame() :
	GameLoopSignals.StartNewGame.emit()

func ReturnToMenu() :
	GameLoopSignals.GoToMainMenu.emit()

func EndVictoryScreen() :
	CloseScene()
