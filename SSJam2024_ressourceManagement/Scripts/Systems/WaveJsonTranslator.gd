extends Node

class_name WaveJsonTranslator

static func ArrayToJson(waveStep, array,step) :
	if array.size() < step + 1 :
		array.resize(step +1)
	if array[step] == null :
		array.insert(step,waveStep)
	else :
		array[step] = waveStep
	return array
	
static func JsonToArray(data) :
	if data == null :
		var array = Array()
		array.resize(1)
		return array
	var placements : Array
	var counter = 0
	placements.resize(data.size())
	for waveStep in data :
		var placement = Array()
		if waveStep != null :
			placement.resize(waveStep.size())
			for i in range(waveStep.size()) :
				var entityPlacement = waveStep[i]
				placement[i] = [entityPlacement[0],entityPlacement[1]]
		placements[counter] = placement
		counter+= 1
	return placements
