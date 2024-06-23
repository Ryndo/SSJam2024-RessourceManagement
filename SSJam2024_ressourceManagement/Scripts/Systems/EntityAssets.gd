class_name EntityAssets extends Resource

@export var Type : GameData.EntityType
@export var GameObject : PackedScene
@export var Icon : Texture2D
@export var SoulType : GameData.SoulType
func GetAsset() :
	return {"Type" : Type,"GameObject" : GameObject,"Icon" : Icon, "soulType" : SoulType}
