class_name BaseTotemAbility extends Area3D

@export var areaOfEffect : CollisionShape3D
@export var triggerCooldown : Timer
var entitiesInArea : Array[Entity]

var isInCooldown = false 
var abilityPower

var upgradesAbilities : Array[Callable]

func Setup(range,triggerSpeed,power) :
	areaOfEffect.shape.radius = range
	triggerCooldown.wait_time = 1 /triggerSpeed
	abilityPower = power
	
func Disable() :
	areaOfEffect.disabled = true
	
func Activate() :
	areaOfEffect.disabled = false
	
func EntityEnterArea(body):
	var entity: Entity = body.get_parent()
	if entity == null :
		return
	entity.entityDied.connect(RemoveFromEntitiesInArea,CONNECT_ONE_SHOT)
	entitiesInArea.append(entity)	
		
func EntityExitArea(body):
	var entity : Entity = body.get_parent()
	if entity == null :
		return
	if entitiesInArea.has(entity) :
		entitiesInArea.remove_at(entitiesInArea.find(entity))
		if entity.entityDied.is_connected(RemoveFromEntitiesInArea) :
			entity.entityDied.disconnect(RemoveFromEntitiesInArea)

func RemoveFromEntitiesInArea(entity) :
	if entitiesInArea.has(entity) :
		entitiesInArea.remove_at(entitiesInArea.find(entity))

func TriggerCooldownRefresh() :
	isInCooldown = false

func TriggerAbility() :
	if isInCooldown :
		return
	var entities = GetEntitiesInArea()
	for entity in entities :
		entity.Stats.MovementSpeed = 0
		#entity.Combat.ReceiveAttack(abilityPower)
	isInCooldown = true
	triggerCooldown.start()

func GetEntitiesInArea() :
	var entities : Array[Entity]
	var bodies = get_overlapping_bodies()
	for body in bodies :
		var entity = body.get_parent()
		if entity != null and entity is Entity :
			entities.append(entity)
	return entities
