extends CharacterBody2D

var camera2D: Camera2D
var cameraShakeNoise: FastNoiseLite
@onready var animated_sprite_enemy_3: AnimatedSprite2D = %AnimatedSpriteEnemy3
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

var original_camera_position: Vector2
var shake_intensity: float = 0.0


func SetShader_BlinkIntensity(new_value: float) -> void:
	animated_sprite_enemy_3.material.set_shader_parameter("blink_intensity", new_value)
	
func _ready(): 
	camera2D = %Camera2D2
	original_camera_position = camera2D.position
	cameraShakeNoise = FastNoiseLite.new()
	cameraShakeNoise.seed = randi()
	cameraShakeNoise.frequency = 20.0
	cameraShakeNoise.noise_type = FastNoiseLite.TYPE_SIMPLEX

func _process(delta):
	if shake_intensity > 0.01:
		var t = Time.get_ticks_msec() / 100.0
		var offset = Vector2(
			cameraShakeNoise.get_noise_1d(t),
			cameraShakeNoise.get_noise_1d(t + 100)
		) * shake_intensity
		camera2D.position = original_camera_position + offset
	else:
		camera2D.position = original_camera_position


func ApplyDamage():
	var tween = get_tree().create_tween()
	tween.tween_method(SetShader_BlinkIntensity, 1.0, 0.0, 0.5)

	var camera_tween = get_tree().create_tween()
	camera_tween.tween_property(self, "shake_intensity", 0.0, 0.5).from(5.0)

	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true

	await get_tree().create_timer(0.4).timeout 
	gpu_particles_2d.emitting = false
