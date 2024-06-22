class_name BaseTotemAbility extends Area3D

@export var areaOfEffect : CollisionShape3D
@export var triggerCooldown : Timer
var entitiesInArea : Array[Entity]

var isInCooldown = false 
var abilityPower

func Setup(range,triggerSpeed,power) :
	areaOfEffect.shape.radius = range
	triggerCooldown.wait_time = 1 /triggerSpeed
	abilityPower = power

func EntityEnterArea(body):
	var entity: Entity = body.get_parent()
	if entity == null :
		return
	entity.entityDied.connect(RemoveFromEntitiesInArea)
	entitiesInArea.append(entity)	
		
func EntityExitArea(body):
	var entity : Entity = body.get_parent()
	if entity == null :
		return
	if entitiesInArea.has(entity) :
		entitiesInArea.remove_at(entitiesInArea.find(entity))
		entity.entityDied.disconnect(RemoveFromEntitiesInArea)

func RemoveFromEntitiesInArea(entity) :
	if entitiesInArea.has(entity) :
		entitiesInArea.remove_at(entitiesInArea.find(entity))
		entity.entityDied.disconnect(RemoveFromEntitiesInArea)

func TriggerCooldownRefresh() :
	isInCooldown = false
	

func TriggerAbility() :
	var bodies = get_overlapping_bodies()
	for body in bodies :
		var entity = body.get_parent()
		if entity != null and entity is Entity :
			entity.Combat.ReceiveAttack(abilityPower)
	isInCooldown = true
	triggerCooldown.start()
