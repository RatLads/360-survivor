class_name CameraPivot extends Node3D ####X ROTATION

@export var debug : bool = false
@export_category("References")
@export var player_controller : PlayerController
@export var component_mouse_capture : MouseCaptureComponents
@export_category("Camera Settings")
@export_group("Camera Tilt")

@export_range(-60, 60) var min_pitch := -40
@export_range(-60, 60) var max_pitch := 40
@export var mouse_sensitivity := 0.003
@export var pitch_smoothness := 0.1  # 0 = instant, 1 = very slow

var target_pitch := 0.0
var pitch := 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target_pitch -= event.relative.y * mouse_sensitivity
		target_pitch = clamp(target_pitch, deg_to_rad(min_pitch), deg_to_rad(max_pitch))

func _process(_delta: float) -> void:
	# Smoothly interpolate pitch toward target_pitch
	pitch = lerp(pitch, target_pitch, pitch_smoothness)
	rotation.x = pitch
