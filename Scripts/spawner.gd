extends Node

var enemy_scene: PackedScene = preload("res://Scenes/Enemies/enemy.tscn")

@export var spawn_distance: float = 300.0
@export var max_enemies: int = 5

func _process(_delta: float) -> void:
	var current_enemies = get_tree().get_nodes_in_group("enemies").size()
	if current_enemies < max_enemies:
		spawn_enemy()

func spawn_enemy() -> void:
	var camera = get_viewport().get_camera_2d()
	var viewport_size = get_viewport().get_visible_rect().size
	
	var half_width = viewport_size.x / 2
	var half_height = viewport_size.y / 2
	
	var enemy = enemy_scene.instantiate()
	get_tree().current_scene.add_child.call_deferred(enemy)
		
	var spawn_position = get_spawn_position(
		camera.global_position,
		half_width,
		half_height
	)
		
	enemy.global_position = spawn_position
	enemy.scale = Vector2(0.8, 0.8)

func get_spawn_position(camera_position: Vector2, half_width: float, half_height: float) -> Vector2:
	var side = randi_range(0, 3)
	
	match side:
		0: # Top
			return camera_position + Vector2(
				randf_range(-half_width, half_width),
				-half_height - spawn_distance
			)
		1: # Bottom
			return camera_position + Vector2(
				randf_range(-half_width, half_width),
				half_height + spawn_distance
			)
		2: # Left
			return camera_position + Vector2(
				-half_width - spawn_distance,
				randf_range(-half_height, half_height)
			)
		3: # Right
			return camera_position + Vector2(
				half_width + spawn_distance,
				randf_range(-half_height, half_height)
			)
	
	return camera_position
