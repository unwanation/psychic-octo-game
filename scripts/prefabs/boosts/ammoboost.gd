class_name AmmoBoost
extends Boost


func apply_boost(character: Character) -> void:
	character.boost(
		func():
			character.weapon.max_ammo *= 1.25
	)
	super(character)
