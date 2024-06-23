class_name GoldUI extends Node

@export var goldValue : RichTextLabel

func _ready():
	PlayerItems.GoldAmountChanged.connect(UpdateGolds)
	goldValue.text ="[center]%s[/center]" % str(PlayerItems.Golds)
func UpdateGolds(value) :
	goldValue.text = str(value)
