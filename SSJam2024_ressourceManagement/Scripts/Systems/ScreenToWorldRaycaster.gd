extends Node3D

func CastRayFromMouseScreenPosition(layerMask =-1) :
	var rayOrigin =  get_viewport().get_camera_3d().project_ray_origin(get_viewport().get_mouse_position())
	var rayEnd = rayOrigin + get_viewport().get_camera_3d().project_ray_normal(get_viewport().get_mouse_position()) * 8000
	var parameters : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	if layerMask != -1 :
		parameters.collision_mask = layerMask
	var	rayArray = get_world_3d().direct_space_state.intersect_ray(parameters)
	if rayArray.has("position") :
		return rayArray
	return null

func ShapeCastWorld(transform,mask,radius) :
	var parameters = PhysicsShapeQueryParameters3D.new()
	parameters.shape = CylinderShape3D.new()
	parameters.shape.radius = radius
	parameters.transform = transform
	parameters.collision_mask = mask
	var state = get_world_3d().get_direct_space_state()
	var results = state.intersect_shape(parameters)
	return results
