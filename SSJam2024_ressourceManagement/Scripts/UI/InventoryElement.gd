class_name InventoryElement extends Control

@export var button : TextureButton
@export var background : TextureRect

var disabled = true
var infos
var id

func Fill(asset, itemId) :
	itemId = id
	infos = asset
	button.texture_normal = asset.Icon
	button.visible = true
	disabled = false
	background.visible = true

func Hide() :
	id = null
	disabled = true
	infos = null
	button.visible = false

func Press() :
	if disabled : 
		return
	var mouseWorldPosition = Raycaster.CastRayFromMouseScreenPosition()
	var spawnedEntity = EntitySpawner.get_node("Entity spawner").SpawnEntity(infos.Type,mouseWorldPosition.position,get_node("."))
	spawnedEntity.global_position -= spawnedEntity.Movement.collider.position 
	await get_tree().process_frame
	await get_tree().process_frame
	var mouseWorldPosition2 = Raycaster.CastRayFromMouseScreenPosition(16)
	InputSignal.PickEntity.emit(mouseWorldPosition2,GameData.DragOrigin.UI,OnPlacementSuccess,OnFailure)

func OnPlacementSuccess() :
	PlayerItems.RemoveItemFromInventory(id)
	Hide()

func OnFailure() :
	pass
