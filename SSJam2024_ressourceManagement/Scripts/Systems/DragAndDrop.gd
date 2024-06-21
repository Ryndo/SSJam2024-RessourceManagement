class_name EntityDragAndDrop extends Node3D

@export var startDraggingDelay : Timer
@export var shape : CollisionShape3D
var EntityDragged 
var colliderDragged : CollisionShape3D

var DragOrigin : GameData.DragOrigin
var draggingStartPosition
var isDraggingActivated = false
var isDragging : bool = false

var onSuccess
var onFailure

func _ready():	
	InputSignal.PickEntity.connect(StartDrag)
	InputSignal.Drag.connect(Dragging)
	InputSignal.EndDrag.connect(EndDrag)	
	
func ColisionDelayStart() :
	var rayCollision = CastRayFromMouseScreenPosition()
	if rayCollision != null :
		var object : Node3D = rayCollision.collider.get_parent()
		if object != null and object is Ally:
			startDraggingDelay.start()
			
func StartDrag(rayResult,origin,_onSucces,_onFailure) :
	if rayResult != null : 
		var object : Node3D = CheckForPickable(rayResult.collider)
		if object == null : 
			return
		if object is Ally or object is TotemBase:
			EntityDragged = object
			EntityDragged.Disable()
			isDragging = true
			DragOrigin = origin
			draggingStartPosition = EntityDragged.global_position
			onSuccess = _onSucces
			onFailure = _onFailure
		#if object is TotemBase :
			
func Dragging(rayResult) :
	if !isDragging :
		return
	if rayResult == null or !rayResult.has("position") :
		return
	var tween = create_tween()
	tween.tween_property(EntityDragged, "global_position", rayResult.position, .3).set_ease(Tween.EASE_IN_OUT)

func EndDrag(rayResult) :
	isDraggingActivated = false
	if !isDragging :
		return
	if rayResult == null or !rayResult.has("position") : 		#not a valid position to end drag
		CancelDrag()		
	elif EntityDragged is Ally and !CheckIfSpaceIsFree(rayResult.position,EntityDragged.Movement.collider.shape.radius) :
		CancelDrag()		
	elif EntityDragged is TotemBase and !CheckIfSpaceIsFree(rayResult.position,EntityDragged.collider.shape.radius) :
		CancelDrag()		
	else : 
		EntityDragged.Setup()
		if onSuccess :
			onSuccess.call()
	isDragging = false	
	EntityDragged = null
		
func CastRayFromMouseScreenPosition() :
	var rayOrigin =  get_viewport().get_camera_3d().project_ray_origin(get_viewport().get_mouse_position())
	var rayEnd = rayOrigin + get_viewport().get_camera_3d().project_ray_normal(get_viewport().get_mouse_position()) * 2000
	var parameters : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	parameters.collide_with_areas = true
	var	rayArray = get_world_3d().direct_space_state.intersect_ray(parameters)
	if rayArray.has("position") : 
		return rayArray
	return null
	
func ActivateDrag() :
	isDraggingActivated = true
	
func CheckForPickable(collider) :
	var parent = collider.get_parent()
	if parent == null :
		return null
	var grandParent = parent.get_parent()
	if grandParent != null :
		if grandParent is Ally or grandParent is TotemBase:
			return grandParent
	return null

func CheckIfSpaceIsFree(position,radius) :
	var castResults  = Raycaster.ShapeCastWorld(EntityDragged.transform,6,radius)
	for body in castResults :
		if body != null :
			if body.collider != EntityDragged.Movement :
				return false
	return true
func CancelDrag() :
	if DragOrigin == GameData.DragOrigin.UI :
		EntityDragged.queue_free()		
	else : 
		var tween = create_tween()
		tween.tween_property(EntityDragged, "global_position", draggingStartPosition, .3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
		EntityDragged.Setup()
	if onFailure :
		onFailure.call()
