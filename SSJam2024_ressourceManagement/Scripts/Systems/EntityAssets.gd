class_name EntityAssets extends Resource

@export var Type : GameData.EntityType
@export var GameObject : PackedScene
@export var Icon : Texture2D

func GetAsset() :
	return {"Type" : Type,"GameObject" : GameObject,"Icon" : Icon}
