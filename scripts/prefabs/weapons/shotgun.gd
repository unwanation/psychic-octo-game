class_name Shotgun
extends Weapon


func _enter_tree() -> void:
	super()
	cooldown = 1
	reload_time = 2
	recoil = 0.5
	bullet_acceleration = 500
	bullet_lifetime = 0.5
	ammo_in_magazine = 25
	ammo = ammo_in_magazine
	max_ammo = 50


func shoot() -> void:
	if is_working and !$CheckArea.has_overlapping_bodies() and try_spend_ammo(5):
		rebound()
		
		for i in range(-2, 3):
			var bullet: Bullet = BULLET.instantiate() if is_player else BULLET_ENEMY.instantiate()
			bullet._init(bullet_lifetime, Vector2(0.8, 0.8))
			bullet.set_position($BulletsSpawnPos.get_global_position())
			bullet.set_axis_velocity(Vector2.from_angle(rotation + deg_to_rad(15 * i)) * bullet_acceleration)
			Root.get_current_scene().get_node("Bullets").add_child(bullet)
		
		emit_signal("shot")
		wait_cooldown()
	super()

