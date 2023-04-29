extends EnemyAI

class_name EnemyVariantOne

var bullet_object = preload("res://src/objects/bullets/enemy_bullet_heavy_variant_1.tscn")
var able_to_attack: bool

func init() -> void:
	super._init()
	able_to_attack = false

func create_bullet() -> void:
	var position_to_fire_to = self.get_player_position()
	var bullet = bullet_object.instantiate()
	bullet.shoot_bullet(self.position, position_to_fire_to)
	self.get_tree().get_root().add_child(bullet)
	self.able_to_attack = false

func _set_state_attacking() -> void:
	super._set_state_attacking()
	self.able_to_attack = true

func attack() -> void:
	if able_to_attack:
		self.create_bullet()

func step() -> void:
	if self.state == State.ATTACKING:
		self.attack()

func _process(delta) -> void:
	self.step()
