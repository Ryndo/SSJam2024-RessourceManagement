extends GameState

func EnnemiesAreAllDead() :
	GameLoopSignals.RoundEnded.emit()

func OriginalTotemIsDead() :
	GameLoopSignals.OriginalTotemIsDead.emit()
