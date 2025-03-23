extends Area2D

@export var speed := 400.0

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.has_method("ApplyDamage"):
		body.ApplyDamage()
	queue_free()

func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta
