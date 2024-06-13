extends Node

class_name EntityPathfinding

var navigationServer : NavigationServer
var navigationPath : PackedVector2Array
var distanceTreshold = 12

func _ready():
	CustomSignals.OnServerSetuped.connect(getServer)
	#navigationServer = get_node("/root/CustomNavigationServer")
	
func CalculatePath(position, targetPosition) :
	navigationPath = navigationServer.GetPath(position,targetPosition)
	
func IsPathEmpty() :
	return navigationPath == null or navigationPath.size() == 0
	
func GetNextPathPoint() :
	return navigationPath[0]
	
func RemoveNextPathPoint() :
	navigationPath.remove_at(0)

func IsCloseEnough(position) :
	var distanceToNextPoint = position.distance_to(GetNextPathPoint())
	return distanceToNextPoint < distanceTreshold

func getServer(server) :
	navigationServer = server
