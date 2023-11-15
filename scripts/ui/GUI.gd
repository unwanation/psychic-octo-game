extends CanvasLayer


var player: Player
var ammo_visible: bool = false


func _physics_process(_delta: float) -> void:
	if ammo_visible:
		if player.weapon.is_working:
			$Control/HUD/Ammo.label_settings.font_color.a = 1
		else:
			$Control/HUD/Ammo.label_settings.font_color.a = 0.5


func show_gui() -> void:
	set_process_mode(Node.PROCESS_MODE_INHERIT)
	show()


func show_ammo() -> void:
	ammo_visible = true
	player = Root.get_player() as Player
	update_weapon()


func update_weapon() -> void:
	if player.weapon.is_connected("shot", update_ammo):
		player.weapon.disconnect("shot", update_ammo)
	player.weapon.connect("shot", update_ammo)
	if player.weapon.has_infinite_ammo:
		$Control/HUD/Ammo.hide()
		$Control/HUD/ProgressBar.show()
	else:
		$Control/HUD/Ammo.show()
		$Control/HUD/ProgressBar.hide()
	if !player.weapon.has_infinite_ammo:
		update_ammo()


func update_ammo() -> void:
	if player.weapon.has_infinite_ammo:
		var tween = create_tween() as Tween
		tween.set_trans(Tween.TRANS_BACK)
		tween.tween_property($Control/HUD/ProgressBar, "value", 0, player.weapon.bullet_lifetime)
		tween.tween_property($Control/HUD/ProgressBar, "value", 50, player.weapon.cooldown + player.weapon.bullet_lifetime)
		tween.tween_callback(tween.kill)
	else:
		$Control/HUD/Ammo.set_text("%s/%s" % [player.weapon.ammo, player.weapon.max_ammo])


func show_interactable_object(object: String) -> void:
	match object:
		"TV":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nначать игру")
		"Wardrobe":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nсменить скин")
		"Table":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nсменить ник")
		"Door":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nвыйти")


func hide_interactable_object() -> void:
	$Control/HUD/Clue.set_text("")
