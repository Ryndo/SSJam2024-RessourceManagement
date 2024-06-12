extends Node2D

class_name NavigationServer 

@export var line : Line2D

signal serverSetuped(server : NavigationServer)
var map = null

func _ready():
	call_deferred("custom_setup")
	pass

func custom_setup() :
	map  = get_world_2d().get_navigation_map()
	serverSetuped.emit(self)


func getMap() :
	return map

func GetPath(start,end) :
	var parameters : NavigationPathQueryParameters2D = NavigationPathQueryParameters2D.new()
	parameters.path_postprocessing = NavigationPathQueryParameters2D.PATH_POSTPROCESSING_EDGECENTERED
	parameters.start_position = start
	parameters.target_position = end
	parameters.map = map
	var results = NavigationPathQueryResult2D.new()
	NavigationServer2D.query_path(parameters,results)
	var path = results.get_path()
	line.clear_points()
	for point in path :
		line.add_point(point)
	return path
