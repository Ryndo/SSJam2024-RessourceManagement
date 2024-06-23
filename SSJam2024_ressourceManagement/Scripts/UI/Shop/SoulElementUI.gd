class_name SoulElement extends Node

@export var Icon : TextureRect
@export var SoulQuantity : RichTextLabel

var soulType

signal SoulPicked(type)

func UpdateDisplay(icon,value,type) :
	#Icon.texture = icon
	SoulQuantity.text = str(value)
	soulType = type

func HoveredIn():
	SignalUi.DisplaySoulTooltip.emit(soulType)


func HoveredOut():
	SignalUi.HideSoulTooltip.emit()


func Picked():
	SoulPicked.emit(soulType)
