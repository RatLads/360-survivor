extends CharacterBody3D


@export var speed: int = 1
@export var health: int =100
@export var debug: bool = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var altTexture = preload("res://assets/textures/enemies/sillyrat.jpeg")

func _ready() -> void:
	var rand = randi_range(0, 6)
	if (rand<= 3):
		$Sprite3D.texture = altTexture
		
func _physics_process(_delta: float) -> void:
	velocity.x = speed
	move_and_slide()
	
func take_damage(amount):
	health -= amount
	$Health.value = health
	if health <= 0:
		queue_free()
