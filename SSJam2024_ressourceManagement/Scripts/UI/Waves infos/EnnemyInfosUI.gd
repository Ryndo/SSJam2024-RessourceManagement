class_name EnnemyInfoUI extends Control

@export var Icon : TextureRect
@export var Quantity : Label

func UpdateDisplay(icon,quantity) :
	Icon.texture = icon
	Quantity.text = str(quantity)
	visible = true
	
func Hide() :
	visible = false
