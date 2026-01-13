extends RayCast3D

var current_object

var collision_point: Vector3 = get_collision_point()

func _ready() -> void:
	enabled = true

func _process(_delta: float) -> void:
	
	if is_colliding():
		var object = get_collider()
		if object == current_object:
			return
		if object == null or not is_instance_valid(object):
			return
		if object is MeshInstance3D:
			current_object = object
			return
		if object is CollisionObject3D:
			current_object = object
			return
		else:
			current_object = object
	else:
		current_object = null
