extends CharacterBody2D
@onready var animated_sprite_dissapear: AnimatedSprite2D = %AnimatedSpriteDissapear

func _process(delta):
	animated_sprite_dissapear.material.set_shader_parameter("DissolveValue", sin(Time.get_ticks_msec()*0.002)+ 0.05)
