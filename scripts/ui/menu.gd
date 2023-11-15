extends Control


func _on_play_pressed() -> void:
	$Server.show()


func _on_settings_pressed() -> void:
	pass


func _on_exit_pressed() -> void:
	Root.quit()


func _on_settings_hovered() -> void:
	$Background/Glitch.hide()
	$Background/SettingsGlitch.show()


func _on_settings_unhovered() -> void:
	$Background/Glitch.show()
	$Background/SettingsGlitch.hide()
