extends Node

@export var Assets : Array[BoosterAsset]

func GetAsset(type : GameData.BoosterType) :
	for asset in Assets :
		if type == asset.Type :
			return asset
	return null
