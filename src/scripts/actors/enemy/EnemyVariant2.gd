extends EnemyAI

class_name EnemyVariantTwo

var bullet_object = preload("res://src/objects/bullets/enemy_bullet_heavy_variant_1.tscn")
var able_to_attack: bool

func init() -> void:
	super._init()
	able_to_attack = false


func _rotate_bullets(bullets: Array) -> void:
	bullets[1].velocity = bullets[1].velocity.rotated(1) #angle in radians
	bullets[2].velocity = bullets[2].velocity.rotated(-1)

func _add_bullets_to_scene(bullets: Array) -> void:
	for bullet in bullets:
		self.get_tree().get_root().add_child(bullet)

func _create_bullets(bullets: Array):
	var position_to_fire_to = self.get_player_position()
	for bullet in bullets:
		bullet.redirect_bullet(self.position, position_to_fire_to)
	self._rotate_bullets(bullets)

func redirect_bullets() -> void:
	var bullets = [bullet_object.instantiate(), bullet_object.instantiate(), bullet_object.instantiate()]
	self._create_bullets(bullets)
	self._add_bullets_to_scene(bullets)
	self.able_to_attack = false

func _set_state_attacking() -> void:
	super._set_state_attacking()
	self.able_to_attack = true

func attack() -> void:
	if able_to_attack:
		self.redirect_bullets()

func step() -> void:
	if self.state == State.ATTACKING:
		self.attack()

func _process(delta) -> void:
	self.step()
