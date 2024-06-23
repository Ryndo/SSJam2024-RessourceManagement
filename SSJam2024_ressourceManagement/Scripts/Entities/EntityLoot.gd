class_name EntityLoot extends Node

var dropType : GameData.LootType
var quantity : int

var entityType

func Setup(lootType,_quantity,_entityType) :
	dropType = lootType
	quantity = _quantity
	entityType = _entityType
	
func DropLoot() :
	if dropType == GameData.LootType.gold :
		PlayerItems.EarnGold(quantity)
		
	elif dropType == GameData.LootType.soul :
		var asset = EntityTypeToAsset.GetAsset(entityType)
		PlayerItems.AddSoulToInventory(GameData.SoulType.keys()[asset.soulType],quantity)
	pass
