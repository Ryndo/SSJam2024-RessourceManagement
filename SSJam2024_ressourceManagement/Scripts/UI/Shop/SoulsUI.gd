class_name SoulsUI extends Node

@export var Elements : Array[SoulElement]

func _ready():
	PlayerItems.SoulInventoryChanged.connect(UpdateDisplay)
	
func UpdateDisplay() :
	var soulsInventory = PlayerItems.Souls
	var soulTypes = PlayerItems.Souls.keys()
	for index in range(soulTypes.size()) :
		var enumValue = GameData.SoulType.values()[index]
		var datas = SoulsDatas.GetSoul(enumValue)
		Elements[index].UpdateDisplay(datas.Icon,soulsInventory[soulTypes[index]],soulTypes[index])
		
func TryToBuyTotem(soulType) :
	var totemDatas = SoulsDatas.GetSoul(GameData.SoulType[soulType])
	var mouseWorldPosition = Raycaster.CastRayFromMouseScreenPosition()
	var spawnedEntity = EntitySpawner.get_node("Entity spawner").SpawnEntity(totemDatas.TotemType,mouseWorldPosition.position,get_node("."))
	spawnedEntity.global_position -= spawnedEntity.collider.position 
	await get_tree().process_frame
	await get_tree().process_frame
	var mouseWorldPosition2 = Raycaster.CastRayFromMouseScreenPosition(16)
	InputSignal.PickEntity.emit(mouseWorldPosition2,GameData.DragOrigin.UI,OnPlacementSuccess,OnFailure)

func OnPlacementSuccess() :
	print("succes")
	

func OnFailure() :
	pass
