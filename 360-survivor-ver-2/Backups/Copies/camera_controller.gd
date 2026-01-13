class_name CameraController extends Node3D

@export var debug : bool = false
@export_category("References")
@export var player_controller : PlayerController
@export var component_mouse_capture : MouseCaptureComponents
@export_category("Camera Settings")
@export_group("Camera Tilt")
@export_range(-60, -60) var tilt_lower_limit : int = -50
@export_range(60, 60) var tilt_upper_limit : int = 50
@export_group("Camera Rotation")
@export var rotation_step_degrees := 45.0

var rotation_index := 0
var _rotation : Vector3

func _process(_delta: float) -> void:
	update_camera_rotation(component_mouse_capture._mouse_input)
	
func update_camera_rotation(input: Vector2) -> void:
	_rotation.x += -input.y
	_rotation.y += -input.x 
	_rotation.x = clamp(_rotation.x, deg_to_rad(tilt_lower_limit), deg_to_rad(tilt_upper_limit))
	_rotation.z = 0.0
	
	var _player_rotation = Vector3(0.0, _rotation.y, 0.0)
	var _camera_rotation = Vector3(_rotation.x, 0.0,  0.0)
	transform.basis = Basis.from_euler(_camera_rotation)
	player_controller.update_rotation(_player_rotation)
	
func apply_snap_rotation() -> void:
	var rot := rotation_degrees
	rot.y = rotation_index * rotation_step_degrees
	rotation_degrees = rot
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		rotation_index -= 1
		apply_snap_rotation()

	if event.is_action_pressed("ui_right"):
		rotation_index += 1
		apply_snap_rotation()
	
