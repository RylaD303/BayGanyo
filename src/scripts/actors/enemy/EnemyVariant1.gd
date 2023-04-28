extends EnemyAI

class_name EnemyVariantOne

var bullet_object = preload("res://src/objects/bullets/enemy_bullet_heavy_variant_1.tscn").instantiate()
var shot_bullets: bool
func init() -> void:
	super._init()
	shot_bullets = true

func create_bullets() -> void:
	var position_to_fire_to = $Player.position
	var bullet = bullet_object
	bullet_object.set_starting_positon(self.position)
	bullet_object.set_direction_to_position(position_to_fire_to)
	self.get_parent().add_bullet(bullet_object)

func _set_state_attacking() -> void:
	self.state = State.ATTACKING
	self.velocity = Vector2.ZERO
	self.shot_bullets = false

func shoot():
	if !shot_bullets:
		self.create_bullets()

func step():
	if self.state == State.ATTACKING:
		self.shoot()

func _process(delta):
	self.step()
