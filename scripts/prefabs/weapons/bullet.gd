class_name Bullet
extends RigidBody2D


var lifetime: float
var scale_modifier: Vector2


func _init(bullet_lifetime: float = 1, bullet_scale := Vector2.ONE) -> void:
	lifetime = bullet_lifetime
	scale_modifier = bullet_scale


func _ready() -> void:
	$CollisionShape2D.set_scale(scale_modifier)
	$Sprite.set_scale(scale_modifier)
	$LifeTimer.start(lifetime)


func _on_body_entered(body: Node2D) -> void:
	if body is Character:
		body.kill()
		body.rpc("kill")
		destroy()
	else:
		destroy()


func _on_life_timer_timeout() -> void:
	destroy()


func destroy():
	$CollisionShape2D.set_deferred("disabled", true)
	set_deferred("freeze", true)
	var tween = create_tween()
	tween.tween_property($Sprite, "scale", scale_modifier / 2, 0.05)
	tween.tween_property($Sprite, "modulate:a", 0, 0.1)
	tween.tween_callback(queue_free)



