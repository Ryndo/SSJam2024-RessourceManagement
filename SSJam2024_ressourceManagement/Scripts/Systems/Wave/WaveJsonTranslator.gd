extends Node

class_name WaveJsonTranslator

static func ArrayToJson(waveStep, array,step) :
	if array == null :
		return [waveStep]
	if array.size() < step + 1 :
		array.resize(step +1)
	if array[step] == null :
		array[step] = waveStep
	else :
		array[step] = waveStep
	return array
	
static func JsonToArray(data) :
	if data == null :
		var array = Array()
		array.resize(1)
		return array
	var placements =  Array()
	var counter = 0
	#placements.resize(data.size())
	for waveStep in data :
		if waveStep != null and waveStep.size() == 2:
			var step = Array()
			step.resize(2)
			var placement = Array()
			for i in waveStep[0] :
				var entityPlacement = i
				placement.append([entityPlacement[0],entityPlacement[1]])
			step[0] = placement
			step[1] =waveStep[1]
			placements.append(step)
		counter+= 1
	return placements
