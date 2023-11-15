class_name Player
extends Character


signal changed_weapon


var player_name: String = "Player"
var player_skin: Skins = Skins.PLANKTON


func _physics_process(delta: float) -> void:
	if !is_blocked:
		move_by_input()
		weapon_input()
	else:
		velocity = Vector2.ZERO
	super(delta)
	
	rpc("remote_set_position", position)
	rpc("remote_set_angle", angle)


func _on_interact_area_body_entered(body: StaticBody2D) -> void:
	Gui.show_interactable_object(body.get_name())


func _on_interact_area_body_exited(_body: StaticBody2D) -> void:
	Gui.hide_interactable_object()


func change_weapon(new_weapon: Weapons) -> void:
	super(new_weapon)
	emit_signal("changed_weapon")


func move_by_input() -> void:
	var direction := Vector2(Input.get_axis(GLOBAL.ACTIONS.LEFT, GLOBAL.ACTIONS.RIGHT), 
			Input.get_axis(GLOBAL.ACTIONS.UP, GLOBAL.ACTIONS.DOWN)).normalized()
	if direction.y:
		velocity.y = direction.y * GLOBAL.PLAYER_SPEED * speed_modifier
	else:
		velocity.y = move_toward(velocity.y, 0, GLOBAL.PLAYER_SPEED * speed_modifier)
	if direction.x:
		velocity.x = direction.x * GLOBAL.PLAYER_SPEED * speed_modifier
	else:
		velocity.x = move_toward(velocity.x, 0, GLOBAL.PLAYER_SPEED * speed_modifier)
	
	angle = rad_to_deg(get_angle_to(get_global_mouse_position()))


func weapon_input() -> void:
	if Input.is_action_pressed(GLOBAL.ACTIONS.SHOOT):
		weapon.shoot()
		rpc("remote_weapon_shoot")


func _unhandled_input(event: InputEvent) -> void:
	### debug
	if event is InputEventKey:
		match event.keycode:
			KEY_0: change_weapon(Weapons.NONE)
			KEY_1: change_weapon(Weapons.RIFLE)
			KEY_2: change_weapon(Weapons.SNIPER)
			KEY_3: change_weapon(Weapons.SHOTGUN)
	###


