class_name CameraController extends Node3D 

@export var debug : bool = false
@export_category("References")
@export var player_controller : PlayerController
@export_category("Camera Settings")
@export_group("Camera Rotation")
@export var snap_angle_degrees := 45.0
@export var snap_duration := 0.15

var snap_index := 0
var target_y_rotation := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		snap_index += 1
		apply_snap_yaw()

	if event.is_action_pressed("ui_right"):
		snap_index -= 1
		apply_snap_yaw()

func apply_snap_yaw() -> void:
	target_y_rotation = snap_index * snap_angle_degrees
	var tween := create_tween()
	tween.tween_property(self, "rotation_degrees:y", target_y_rotation, snap_duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
