extends EnemyAI

class_name EnemyVariantOne

var bullet_object = preload("res://src/objects/bullets/enemy_bullet_heavy_variant_1.tscn")
var shot_bullets: bool
func init() -> void:
	super._init()
	shot_bullets = true

func create_bullets() -> void:
	
	var position_to_fire_to: Vector2 = Vector2.ZERO
	var player = self.get_tree().get_node("res://src/scripts/actors/player/Player.gd")
	if player:
		position_to_fire_to = player.position
	var bullet = bullet_object.instantiate()
	bullet.set_starting_position(self.position)
	bullet.set_direction_to_position(position_to_fire_to)
	self.get_tree().get_root().add_child(bullet)

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
