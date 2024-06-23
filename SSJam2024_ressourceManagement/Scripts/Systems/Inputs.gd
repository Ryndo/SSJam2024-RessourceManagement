extends Node

var leftClickJustPressed = true
var actionsCurrentlyPressed = Array()

func _unhandled_input(event):
	#Attempt to start dragging an entity
	if GameLoop.currentGameState == GameData.GameplayLoopState.Preparation :
		if Input.is_action_just_pressed("LeftClick") :
			var rayResult = Raycaster.CastRayFromMouseScreenPosition(16)
			if rayResult != null and rayResult.has("position") :
				InputSignal.PickEntity.emit(rayResult,GameData.DragOrigin.World,null,null)
			return
			
		#Attempt to keep dragging an entity
		if Input.is_action_pressed("LeftClick") :
			var rayResult = Raycaster.CastRayFromMouseScreenPosition(32)
			InputSignal.Drag.emit(rayResult)
			
		#End dragging 	
		if Input.is_action_just_released("LeftClick") :
			var index = actionsCurrentlyPressed.find("Drag")
			var rayResult = Raycaster.CastRayFromMouseScreenPosition(8)
			InputSignal.EndDrag.emit(rayResult)


