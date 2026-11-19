extends Area2D

var speed : float = 500
var direction : Vector2

func _ready() -> void:
	despawn()
	
func _process(delta: float) -> void:
	global_position += direction * speed * delta
	
	var screen_position = get_global_transform_with_canvas().origin
	var screen_size = get_viewport_rect().size

	if screen_position.x <= 0 or screen_position.x >= screen_size.x:
		direction.x *= -1
		

	if screen_position.y <= 0 or screen_position.y >= screen_size.y:
		direction.y *= -1
		
	

func despawn() -> void:
	await get_tree().create_timer(30).timeout
	queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		direction = body.global_position.direction_to(global_position)
	if body.is_in_group("enemies"):
		direction = body.global_position.direction_to(global_position)
		body.take_damage()
	if body.is_in_group("asteroid"):
		direction = body.global_position.direction_to(global_position)
