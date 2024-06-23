extends Node



@export var souls : Array[SoulAsset]	

func GetSoul(soulType : GameData.SoulType) :
	for soul in souls :
		if soul.type == soulType :
			return soul
			
	return null
	
