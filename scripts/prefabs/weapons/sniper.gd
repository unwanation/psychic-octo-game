class_name Sniper
extends Weapon


func _enter_tree() -> void:
	super()
	cooldown = 6
	reload_time = 0
	recoil = 1
	bullet_acceleration = 0
	bullet_lifetime = 1
	has_infinite_ammo = true


func _on_laser_body_entered(body: Character) -> void:
	body.kill()
	body.rpc("kill")


func shoot() -> void:
	if is_working and try_spend_ammo(1):
		get_parent().get_parent().is_blocked = true
		$AnimationPlayer.play("shoot")
		emit_signal("shot")
		await $AnimationPlayer.animation_finished
		get_parent().get_parent().is_blocked = false
		
		wait_cooldown()
