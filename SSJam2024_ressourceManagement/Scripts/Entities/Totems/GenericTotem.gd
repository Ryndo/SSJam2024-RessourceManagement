class_name TotemBase extends Node3D

@export var Stats : TotemStats
@export var Body : StaticBody3D
@export var collider : CollisionShape3D
@export var Targeting : EntityTargeting
@export var AbilityArea : BaseTotemAbility
@export var UpgradePosition : Node3D
@export var PickupCollider : CollisionShape3D
@export var upgrade : TotemUpgrade

var upgrades : Array[TotemBase]
var activated = false
var isAnUpgrade = false

func _ready():
	GameLoopSignals.StartNewRound.connect(Activate)
	pass
	
func Setup() :
	print(name)
	Targeting.Setup(Body,Stats.AbilityRange)
	AbilityArea.Setup(Stats.AbilityRange,Stats.AbilitySpeed,Stats.AbilityPower)
	PickupCollider.disabled = false
	collider.disabled = false

func Disable() :
	activated = false
	PickupCollider.disabled = true
	collider.disabled = true
	AbilityArea.Disable()
	
func Activate() :
	if !isAnUpgrade :
		activated = true
		AbilityArea.Activate()
	
func _process(delta):
	if activated and !isAnUpgrade and !AbilityArea.isInCooldown:
		AbilityArea.TriggerAbility()
		TriggerUpgradeAbilities()

func AttachUpgrade(totem) :
	upgrades.append(totem)
	totem.global_position = UpgradePosition.global_position
	UpgradePosition.global_position = totem.UpgradePosition.global_position
	totem.reparent(UpgradePosition)
	totem.IsAnUpgrade()
	totem.upgrade.ApplyUpgrade(self)
	
	
func IsAnUpgrade() :
	isAnUpgrade = true
	Disable()
	
func TriggerUpgradeAbilities() :
	var entities = AbilityArea.GetEntitiesInArea()
	for upgrade in upgrades :
		upgrade.upgrade.TriggerAbility(entities)
