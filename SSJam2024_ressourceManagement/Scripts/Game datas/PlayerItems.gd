extends Node

class inventoryItem :
	var entityType
	var Id
	
	func  _init(type,_id):
		entityType = type
		Id = _id

var InventoryItems : Array[inventoryItem]
var itemId = 0

var Golds : int = 0

var Souls : Array[GameData.SoulType]


func AddItemToInventory(entity :GameData.EntityType) :
	InventoryItems.append(inventoryItem.new(entity,itemId))
	itemId += 1

func RemoveItemFromInventory(id) :
	for index in range(InventoryItems.size()) :
		if InventoryItems[index].Id == id :
			InventoryItems.remove_at(index)


func GetInventory() :
	return InventoryItems

func Reset() :
	InventoryItems.clear()
	itemId = 0
	Golds = 0
	Souls.clear()
	
