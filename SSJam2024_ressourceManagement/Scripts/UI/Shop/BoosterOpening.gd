class_name BoosterOpening extends Control

@export var cardsUI : Array[CardUI]

func OpenBooster(booster : BoosterAsset) :
	visible = true
	var cards = GetCards(booster.EntityPool)
	for index in range(cards.size()) :
		var asset = EntityTypeToAsset.GetAsset(cards[index])
		cardsUI[index].FillCard(asset)
		


func GetCards(pool) :
	var cards = Array()
	var temporaryPool = pool.duplicate()
	for i in range(GameData.CARD_PER_BOOSTER) :
		if temporaryPool.size() == 0 :
			return cards
		var randomIndex = randi_range(0,temporaryPool.size()-1)
		var cardType = temporaryPool[randomIndex]
		cards.append(cardType)
		temporaryPool.remove_at(randomIndex)
	return cards

func CardPicked(card) :
	PlayerItems.AddItemToInventory(card)
	for cardUI in cardsUI :
		cardUI.visible = false
	visible = false
