class_name EntityDragAndDrop extends Node3D

@export var startDraggingDelay : Timer
@export var shape : CollisionShape3D
var EntityDragged : Entity
var colliderDragged : CollisionShape3D

var DragOrigin : GameData.DragOrigin
var draggingStartPosition
var isDraggingActivated = false
var isDragging : bool = false


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
			
func StartDrag(rayResult,origin) :
	if rayResult != null : 
		var object : Node3D = CheckForAlly(rayResult.collider)
		if object != null and object is Ally:
			colliderDragged = rayResult.collider.get_node("Collider")
			EntityDragged = object
			EntityDragged.Disable()
			isDragging = true
			colliderDragged.disabled = true
			DragOrigin = origin
			draggingStartPosition = EntityDragged.global_position
			
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
	if rayResult == null or !rayResult.has("position") or !CheckIfSpaceIsFree(rayResult.position,EntityDragged.Movement.collider.shape.radius) :		#not a valid position to end drag
		CancelDrag()		
	else : 
		EntityDragged.Setup()
	isDragging = false	
	colliderDragged.disabled = false
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
	
func CheckForAlly(collider) :
	var parent = collider.get_parent()
	if parent == null :
		return null
	var grandParent = parent.get_parent()
	if grandParent != null :
		if grandParent is Ally :
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
