extends Button

func _pressed():
	var mouseWorldPosition = Raycaster.CastRayFromMouseScreenPosition()
	if mouseWorldPosition == null :
		return 
	var spawnedEntity = EntitySpawner.get_node("Entity spawner").SpawnEntity(GameData.EntityType.Ally,mouseWorldPosition.position,get_node("."))
	spawnedEntity.global_position -= spawnedEntity.Movement.collider.position 
	await get_tree().process_frame
	await get_tree().process_frame
	var mouseWorldPosition2 = Raycaster.CastRayFromMouseScreenPosition(16)
	InputSignal.PickEntity.emit(mouseWorldPosition2,GameData.DragOrigin.UI)
	
