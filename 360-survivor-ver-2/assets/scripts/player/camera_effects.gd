class_name CameraEffects extends Node

@export_category("References")
@export var player : PlayerController

@export_category("Effects")
@export var enable_tilt : bool = true

@export_category("Recoil settings")
@export_group("Tilt")
@export var rot_pitch : float = 0.1
@export var rot_roll : float = 0.25
@export var max_pitch : float = 1.0
@export var max_roll : float = 2.5
