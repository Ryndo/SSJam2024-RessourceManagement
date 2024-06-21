extends Node

var currentGameState : GameData.GameplayLoopState = GameData.GameplayLoopState._none

@export var MainMenuScene : PackedScene
@export var PreparationScene : PackedScene
@export var RoundScene : PackedScene
@export var EndRoundScene : PackedScene
@export var VictoryScene : PackedScene
@export var DefeatScene : PackedScene

func _ready() :
	currentGameState = GameData.GameplayLoopState.MainMenu
	GameLoopSignals.StartNewGame.connect(StartNewGame)
	GameLoopSignals.ReadyForNextRound.connect(SwitchToRound)
	GameLoopSignals.EndRoundPhase.connect(SwitchToEndRoundEvents)
	GameLoopSignals.RoundFinishEventsResolved.connect(SwitchToPreparationFromEndRound)
	GameLoopSignals.AllWavesCleared.connect(SwitchToVictory)
	GameLoopSignals.OriginalTotemIsDead.connect(SwitchToDefeat)
	GameLoopSignals.QuitTheGame.connect(CloseTheGame)
	GameLoopSignals.GoToMainMenu.connect(SwitchToMenu)
	
	
func StartNewGame() :
	match  currentGameState :
		GameData.GameplayLoopState.MainMenu :
			GameLoopSignals.EndMainMenu.emit()
		GameData.GameplayLoopState.Defeat :
			GameLoopSignals.EndDefeat.emit()
		GameData.GameplayLoopState.Victory :
			GameLoopSignals.EndVictory.emit()
			
	GameProgression.Reset()
	PlayerItems.Reset()
	currentGameState = GameData.GameplayLoopState.Preparation
	SwitchToPreparation()
	var scene  = preload("res://Scenes/Gameplay.tscn").instantiate()
	get_node("/root/GameScenes").add_child(scene)
	scene.owner = get_node("/root/GameScenes")
	
	
func SwitchToMenu() :
	match currentGameState :
		GameData.GameplayLoopState.Defeat :
			GameLoopSignals.EndDefeat.emit()
		GameData.GameplayLoopState.Victory :
			GameLoopSignals.EndVictory.emit()
	currentGameState = GameData.GameplayLoopState.MainMenu
	var scene  = preload("res://Scenes/MainMenu.tscn").instantiate()
	get_node("/root/GameScenes").add_child(scene)
	scene.owner = get_node("/root/GameScenes")

func SwitchToPreparation() :
	currentGameState = GameData.GameplayLoopState.Preparation
	var scene  = preload("res://Scenes/Preparation.tscn").instantiate()
	get_node("/root/GameScenes").add_child(scene)
	scene.owner = get_node("/root/GameScenes")
	
func SwitchToPreparationFromEndRound() :
	var scene  = preload("res://Scenes/RoudResult.tscn").instantiate()
	get_node("/root/GameScenes").add_child(scene)
	scene.owner = get_node("/root/GameScenes")
	GameLoopSignals.EndRoundResult.emit()
	SwitchToPreparation()
	pass

func SwitchToRound() :
	currentGameState = GameData.GameplayLoopState.Round
	GameLoopSignals.EndPreparation.emit()
	GameLoopSignals.SetupNewRound.emit()
	pass

func SwitchToEndRoundEvents() :
	if GameProgression.CurrentWave >= GameProgression.WaveQuantity :
		SwitchToVictory()
		return
	currentGameState = GameData.GameplayLoopState.EndRound
	var scene  = preload("res://Scenes/RoudResult.tscn").instantiate()
	get_node("/root/GameScenes").add_child(scene)
	scene.owner = get_node("/root/GameScenes")
	
func SwitchToVictory() :
	currentGameState = GameData.GameplayLoopState.Victory
	var scene  = preload("res://Scenes/VictoryScreen.tscn").instantiate()
	get_node("/root/GameScenes").add_child(scene)
	scene.owner = get_node("/root/GameScenes")

func SwitchToDefeat() :
	currentGameState = GameData.GameplayLoopState.Defeat
	var scene  = preload("res://Scenes/DefeatScreen.tscn").instantiate()
	get_node("/root/GameScenes").add_child(scene)
	scene.owner = get_node("/root/GameScenes")

func CloseTheGame() :
	currentGameState = GameData.GameplayLoopState.GameClosed
	GameData.GameplayLoopState._none
	pass
