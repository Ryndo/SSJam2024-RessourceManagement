class_name TotemStats extends Node

@export var AbilityRange : int  : 
	set(value) :
		AbilityRange = value
		valueChanged.emit()
		
@export var AbilitySpeed : float :# trigger per second 
	set(value) :
		AbilitySpeed = value
		valueChanged.emit()
		
@export var AbilityPower : float :
	set(value) :
		AbilityPower = value
		valueChanged.emit()

signal valueChanged
