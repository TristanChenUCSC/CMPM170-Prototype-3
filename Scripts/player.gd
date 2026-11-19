extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var reload_timer : float = 1.5
var can_shoot : bool = true

var projectile_scene : PackedScene = preload("res://Scenes/Projectiles/projectile.tscn")


func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right","move_up","move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	move_and_slide()
	
func _process(_delta: float) -> void:
	var mouse_pos : Vector2 = get_global_mouse_position()
	var mouse_dir : Vector2 = (mouse_pos - global_position).normalized()
	
	rotation = mouse_dir.angle() + PI / 2
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot(mouse_dir)
		
		can_shoot = false
		await get_tree().create_timer(reload_timer).timeout
		can_shoot = true
	
func shoot(mouse_dir: Vector2) -> void:
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)
	
	var spawn_offset = 40
	
	projectile.direction = mouse_dir
	projectile.global_position = global_position + (mouse_dir * spawn_offset)
	
	
