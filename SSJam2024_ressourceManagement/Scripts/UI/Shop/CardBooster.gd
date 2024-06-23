class_name  CardBooster extends Node

@export var price : RichTextLabel
@export var boosterButton : TextureButton
@export var Infos : BoosterAsset

func _ready():
	FillBooster()
	
func FillBooster() :
	boosterButton.texture_normal = Infos.BoosterImage
	price.text = "[center]%s[/center]" % str(Infos.Price)

func Pressed():
	SignalUi.BoosterPurchaseAttempt.emit(Infos)
	pass # Replace with function body.

