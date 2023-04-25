extends EnemyAI

class_name EnemyVariantOne

var bullet_object = preload("res://src/objects/bullets/enemy_bullet_heavy_variant_1.tscn").instantiate()

func init() -> void:
	super._init()

func fire() -> void:
	var position_to_fire_to = $Player.position
	var bullet = bullet_object
	bullet_object.set_starting_positon(self.position)
	bullet_object.set_direction_to_position(position_to_fire_to)
	$BulletHandler.add_bullet(bullet_object)

func _process(delta):
	pass
