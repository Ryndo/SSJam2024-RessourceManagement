class_name TotemBase extends Node3D

@export var Stats : TotemStats
@export var Body : StaticBody3D
@export var collider : CollisionShape3D
@export var Targeting : EntityTargeting
@export var AbilityArea : BaseTotemAbility

var activated = false
func _ready():
	Setup()
	
func Setup() :
	Targeting.Setup(Body,Stats.AbilityRange)
	AbilityArea.Setup(Stats.AbilityRange,Stats.AbilitySpeed,Stats.AbilityPower)

func Disable() :
	activated = false
	
func Activate() :
	activated = true
	
func _process(delta):
	if activated :
		AbilityArea.TriggerAbility()
