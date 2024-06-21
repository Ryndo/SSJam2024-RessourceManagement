extends Node

var leftClickJustPressed = true
var actionsCurrentlyPressed = Array()

func _unhandled_input(event):
	#Attempt to start dragging an entity
	if GameLoop.currentGameState == GameData.GameplayLoopState.Preparation :
		if Input.is_action_just_pressed("LeftClick") :
			var rayResult = Raycaster.CastRayFromMouseScreenPosition()
			if rayResult != null and rayResult.has("position") :
				InputSignal.PickEntity.emit(rayResult,GameData.DragOrigin.World,null,null)
				actionsCurrentlyPressed.append("Drag")
			return
			
		#Attempt to keep dragging an entity
		if Input.is_action_pressed("LeftClick") :
			var rayResult = Raycaster.CastRayFromMouseScreenPosition(32)
			InputSignal.Drag.emit(rayResult)
			
		#End dragging 	
		if Input.is_action_just_released("LeftClick") :
			var index = actionsCurrentlyPressed.find("Drag")
			if index == -1 :
				return
			var rayResult = Raycaster.CastRayFromMouseScreenPosition(8)
			InputSignal.EndDrag.emit(rayResult)

