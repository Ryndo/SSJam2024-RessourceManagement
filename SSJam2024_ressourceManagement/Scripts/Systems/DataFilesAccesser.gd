class_name DataFileAccesser extends Node


static func saveFile(filePathToSave,objectToSave) :
	var json = JSON.new()
	var file = FileAccess.open(filePathToSave, FileAccess.WRITE)
	file.store_string(json.stringify(objectToSave,"\t"))
	file.close()
	file = null
	
static func LoadFile(filePath) :
	var json = JSON.new()
	var file
	if !FileAccess.file_exists(filePath) :
		file = FileAccess.open(filePath, FileAccess.WRITE)
	else :
		file = FileAccess.open(filePath, FileAccess.READ)
	var stringContent = file.get_file_as_string(filePath)
	json.parse(stringContent)
	return json.data 

static func GetWaveFilePath(waveNumber) :
	return  "user://wave_" + str(waveNumber) +".json"
