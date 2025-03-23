extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animated_sprite_player_3: AnimatedSprite2D = %AnimatedSpritePlayer3

var direction := Input.get_axis("left", "right")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("shoot"):
		animated_sprite_player_3.play("fire")
		shoot()
	
func _on_AnimatedSpritePlayer_animation_finished():
	if animated_sprite_player_3.animation == "fire":
		shoot()

	if is_on_floor():
		if abs(direction) < 0.1:
			animated_sprite_player_3.play("Idle")
		
		
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func shoot():
	var bullet = preload("res://Scenes/fire.tscn").instantiate()
	bullet.global_position = %ShootingPoint_3.global_position
	bullet.rotation = %ShootingPoint_3.global_rotation
	get_parent().add_child(bullet)
	
