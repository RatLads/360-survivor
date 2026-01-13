class_name PlayerController extends CharacterBody3D

@export var debug : bool = false
@export_category("References")
@export var camera : CameraController
@export var standing_collisiion : CollisionShape3D
@export var interaction_raycast : RayCast3D

func update_rotation(rotation_input) -> void:
	global_transform.basis = Basis.from_euler(rotation_input)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
