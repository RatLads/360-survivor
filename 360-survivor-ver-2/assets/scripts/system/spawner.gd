extends Node3D

@onready var spawn_timer = $spawnTimer

const enemy = preload("res://scenes/enemies/enemytest.tscn")

func _ready():
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	var newEnemy = enemy.instantiate()
	
	get_parent().add_child(newEnemy)
	
	newEnemy.global_position = global_position
	print("Spawning enemy at ", global_position)
