extends Node

var currentGameState : GameData.GameplayLoopState = GameData.GameplayLoopState._none

func _ready() :
	GameLoopSignals.StartNewGame.connect(SwitchToPreparation)
	GameLoopSignals.ReadyForNextRound.connect(SwitchToRound)
	GameLoopSignals.RoundEnded.connect(SwitchToEndRoundEvents)
	GameLoopSignals.EndRoundEventsResolved.connect(SwitchToPreparation)
	GameLoopSignals.AllWavesCleared.connect(SwitchToVictory)
	GameLoopSignals.OriginalTotemIsDead.connect(SwitchToDefeat)
	GameLoopSignals.QuitTheGame.connect(CloseTheGame)
	GameLoopSignals.GoToMainMenu.connect(SwitchToMenu)
	
func _process(delta):
	pass
	
	
func SwitchToMenu() :
	currentGameState = GameData.GameplayLoopState.MainMenu
	pass
	
func SwitchToPreparation() :
	currentGameState = GameData.GameplayLoopState.Preparation
	GameData.GameplayLoopState.Preparation
	pass

func SwitchToRound() :
	currentGameState = GameData.GameplayLoopState.Round
	print("ready")
	GameData.GameplayLoopState.Round
	pass

func SwitchToEndRoundEvents() :
	currentGameState = GameData.GameplayLoopState.EndRound
	GameData.GameplayLoopState.EndRound
	pass
	
func SwitchToVictory() :
	currentGameState = GameData.GameplayLoopState.Victory
	GameData.GameplayLoopState.Victory
	pass

func SwitchToDefeat() :
	currentGameState = GameData.GameplayLoopState.Defeat
	GameData.GameplayLoopState.Defeat
	pass	

func CloseTheGame() :
	currentGameState = GameData.GameplayLoopState.GameClosed
	GameData.GameplayLoopState._none
	pass
