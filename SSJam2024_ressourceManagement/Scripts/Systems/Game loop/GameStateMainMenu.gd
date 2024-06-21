extends GameState

func _ready() :
	GameLoopSignals.EndMainMenu.connect(CloseMainMenu)
	
func StartNewGame() :
	GameLoopSignals.StartNewGame.emit()
	
	
func QuitGame() :
	GameLoopSignals.QuitTheGame.emit()

func CloseMainMenu() :
	CloseScene()
