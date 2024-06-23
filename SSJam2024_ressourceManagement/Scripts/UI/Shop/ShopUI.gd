class_name Shop extends Control

@export var golds : GoldUI
@export var boosterOpening : BoosterOpening

func _ready() :
	SignalUi.BoosterPurchaseAttempt.connect(TryToBuyBooster)
	UpdateUI()

func UpdateUI() :
	golds.UpdateGolds(PlayerItems.Golds)

func TryToBuyBooster(booster : BoosterAsset) :
	if !CheckPlayerGoldBalance(booster.Price) or PlayerItems.InventoryItems.size() >= GameData.INVENTORY_CAPACITY:
		return
	PlayerItems.SpendGold(booster.Price)
	OpenBooster(booster)
	pass

func CheckPlayerGoldBalance(amount) :
	return PlayerItems.Golds >= amount

func OpenBooster(booster : BoosterAsset) :
	boosterOpening.OpenBooster(booster)
	
