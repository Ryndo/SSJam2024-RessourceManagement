extends Node

class inventoryItem :
	var entityType
	var Id
	
	func  _init(type,_id):
		entityType = type
		Id = _id

var InventoryItems : Array[inventoryItem]
var itemId = 0

var Golds : int

var Souls = {}

signal GoldAmountChanged(amount)
signal InventoryChanged
signal SoulInventoryChanged

func _ready() :
	InitSoulsInventory()

func AddItemToInventory(entity :GameData.EntityType) :
	InventoryItems.append(inventoryItem.new(entity,itemId))
	itemId += 1
	InventoryChanged.emit()

func RemoveItemFromInventory(id) :
	for index in range(InventoryItems.size()) :
		if InventoryItems[index].Id == id :
			InventoryItems.remove_at(index)
	InventoryChanged.emit()

func AddSoulToInventory(soulType : String, quantity : int) :
	Souls[soulType] += quantity
	SoulInventoryChanged.emit()

func GetInventory() :
	return InventoryItems

func Reset() :
	InitSoulsInventory()
	InventoryItems.clear()
	itemId = 0
	Golds = 99
	
func InitSoulsInventory() :
	Souls.clear()
	for type in GameData.SoulType :
		Souls[type] = 0
		
func EarnGold(amount) :
	Golds += amount
	GoldAmountChanged.emit(Golds)
	
func SpendGold(amount): 
	if amount <= Golds :
		Golds -= amount
		GoldAmountChanged.emit(Golds)
