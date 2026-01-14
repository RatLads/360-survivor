class_name CameraYawSoftLock extends Node3D

@export_range(0, 60) var yaw_limit_degrees := 25.0
@export var mouse_sensitivity := 0.003
@export var yaw_smoothness := 0.1

var target_yaw := 0.0
var yaw := 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_yaw -= event.relative.x * mouse_sensitivity
		target_yaw = clamp(target_yaw,deg_to_rad(-yaw_limit_degrees),deg_to_rad(yaw_limit_degrees))

func _process(_delta: float) -> void:
	yaw = lerp(yaw, target_yaw, yaw_smoothness)
	rotation.y = yaw
