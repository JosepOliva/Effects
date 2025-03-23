extends CharacterBody2D


@onready var animated_sprite_enemy: AnimatedSprite2D = %AnimatedSpritePlayer

func _ready():
	animated_sprite_enemy.play("Idle")

func ApplyDamage():
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)
	
func SetShader_BlinkIntensity(newValue : float):
		animated_sprite_enemy.material.set_shader_parameter("blink_intensity", newValue)
