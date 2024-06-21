extends Control

@export var Elements : Array[InventoryElement]

func _ready():
	PlayerItems.AddItemToInventory(GameData.EntityType.Ally)
	PlayerItems.AddItemToInventory(GameData.EntityType.Ally)
	PlayerItems.AddItemToInventory(GameData.EntityType.Ally)
	Setup()
	

func Setup() :
	var playerInventory = PlayerItems.GetInventory()
	for index in range(Elements.size()) :
		if playerInventory.size() <= index :
			Elements[index].Hide()
		else :
			var assets = EntityTypeToAsset.GetAsset(playerInventory[index].entityType)
			Elements[index].Fill(assets,playerInventory[index].Id)
