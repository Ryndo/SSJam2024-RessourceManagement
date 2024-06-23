extends Control

@export var baseTotemLabel : Label
@export var upgradeTotemLabel : Label

func _ready():
	SignalUi.DisplaySoulTooltip.connect(UpdateTexts)
	SignalUi.HideSoulTooltip.connect(HideToolTip)
	
func UpdateTexts(soulType) :
	var datas = SoulsDatas.GetSoul(soulType as GameData.SoulType)
	baseTotemLabel.text = datas.baseText.text
	visible = true
	
func HideToolTip() :
	visible = false
