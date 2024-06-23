class_name CardUI extends Control

@export var cardImage : TextureButton
@export var cardName : Label
@export var description : Label

var cardAsset

signal CardPicked(card)
func FillCard(asset) :
	cardAsset = asset
	cardImage.texture_normal = asset.Icon
	visible = true

func ChooseCard() :
	CardPicked.emit(cardAsset.Type)
