class_name Boost
extends Area2D


var recover_time: float = 3.5


func _on_body_entered(body: Player) -> void:
	apply_boost(body)


func apply_boost(_character: Character) -> void:
	set_deferred("monitoring", false)
	$Sprite2D.hide()
	await get_tree().create_timer(recover_time).timeout
	$AnimationPlayer.play("recover")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("idle")
	set_deferred("monitoring", true)

