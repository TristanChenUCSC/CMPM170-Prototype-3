extends CharacterBody2D

@onready var sprite : Sprite2D = $Sprite2D


@export var speed : float = 100.0
@export var max_hp : int = 3

var cur_hp : int = max_hp

func _physics_process(_delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		var direction = global_position.direction_to(player.global_position)
		rotation = direction.angle() - PI / 2
		velocity = direction * speed
		move_and_slide()

func _process(_delta: float) -> void:
	if cur_hp == 0:
		queue_free()

func take_damage():
	cur_hp -= 1
	
	sprite.modulate.a = 0.5
	await get_tree().create_timer(0.1).timeout
	sprite.modulate.a = 1.0
