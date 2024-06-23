extends Node

@export var Assets : Array[EntityAssets]

func GetAsset(type : GameData.EntityType) :
	for asset in Assets :	
		if type == asset.Type :
			var aset = asset.GetAsset()
			return asset.GetAsset()
	return null
