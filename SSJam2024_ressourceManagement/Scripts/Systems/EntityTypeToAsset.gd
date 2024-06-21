extends Node

@export var Assets : Array[EntityAssets]

func GetAsset(type : GameData.EntityType) :
	for asset in Assets :
		if type == asset.Type :
			return asset.GetAsset()
	return null
