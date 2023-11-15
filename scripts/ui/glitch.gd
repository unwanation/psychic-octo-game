extends TextureRect


func _on_glitch_timer_timeout() -> void:
	texture.noise.seed += 1
