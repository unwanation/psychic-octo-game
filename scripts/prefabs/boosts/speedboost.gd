class_name SpeedBoost
extends Boost


func apply_boost(character: Character) -> void:
	character.boost(
		func(): 
			character.speed_modifier = 2
			await get_tree().create_timer(2).timeout
			character.speed_modifier = 1
	)
	super(character)
