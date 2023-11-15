class_name Rifle
extends Weapon


func _enter_tree() -> void:
	super()
	cooldown = 0.15
	reload_time = 0.2
	recoil = 0.9
	bullet_acceleration = 1000
	bullet_lifetime = 0.6
	ammo_in_magazine = 10
	ammo = ammo_in_magazine
	max_ammo = 100


func shoot() -> void:
	if is_working and !$CheckArea.has_overlapping_bodies() and try_spend_ammo(1):
		rebound()
		
		var bullet: Bullet = BULLET.instantiate() if is_player else BULLET_ENEMY.instantiate()
		bullet._init(bullet_lifetime, Vector2(0.5, 0.5))
		bullet.set_position($BulletsSpawnPos.get_global_position())
		bullet.set_axis_velocity(Vector2.from_angle(rotation) * bullet_acceleration)
		Root.get_current_scene().get_node("Bullets").add_child(bullet)
		emit_signal("shot")
	
		wait_cooldown()
	super()
