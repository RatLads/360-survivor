class_name CameraController extends Node3D 

@export var debug : bool = false
@export_category("References")
@export var player_controller : PlayerController
@export_category("Camera Settings")
@export_group("Camera Rotation")
@export var snap_angle_degrees: float = 45.0
@export var snap_duration: float = 0.15
@export var lean_degrees: float = 5.0
@export var lean_smoothness: float = 0.15

var snap_index: int = 0
var target_roll: float = 0.0
var roll: float = 0.0

func _ready():
	set_process(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("ui_left"):
		rotate_snap(+1)
	if event.is_action_pressed("ui_right"):
		rotate_snap(-1)

func rotate_snap(direction: int):
	snap_index += direction
	var target_y = snap_index * snap_angle_degrees

	# Smooth snap
	create_tween()\
		.tween_property(self, "rotation_degrees:y", target_y, snap_duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	# Apply lean
	target_roll = deg_to_rad(-lean_degrees * direction)

func _process(_delta):
	# Smooth roll
	roll = lerp(roll, target_roll, lean_smoothness)
	rotation.z = roll
	# Return to neutral when no turn
	target_roll = lerp(target_roll, 0.0, lean_smoothness)
