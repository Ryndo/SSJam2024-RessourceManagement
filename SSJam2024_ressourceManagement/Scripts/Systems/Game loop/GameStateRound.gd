extends GameState

@export var waveManager : WaveManager

func _ready():
	GameLoopSignals.GoToMainMenu.connect(CloseScene)
	GameLoopSignals.SetupNewRound.connect(SetupRound)
	GameLoopSignals.StartNewGame.connect(CloseScene)

func SetupRound() :
	StartRound()
	
func StartRound() :
	var waveNumber = GameProgression.CurrentWave
	waveManager.StartWaves(waveNumber)
	GameLoopSignals.StartNewRound.emit()
	
func EnnemiesAreAllDead() :
	EndRound()

func OriginalTotemIsDead() :
	GameLoopSignals.OriginalTotemIsDead.emit()

func EndRound() :
	GameProgression.CurrentWave += 1
	GameLoopSignals.EndRoundPhase.emit()
	pass
