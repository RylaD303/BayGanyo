extends CharacterBody2D

class_name Bullet

@export var hitbox: Hitbox
var speed = 100

func set_damage(amount: int):
	self.hitbox.set_damage(amount)
	self.setup_hitbox()

func set_starting_position(starting_position: Vector2) -> void:
	self.global_position = starting_position
	
func set_direction_to_position(direction_position: Vector2) -> void:
	# setting the movement vector to be pointiong to the given position
	self.velocity = direction_position - self.global_position
	self.velocity = self.velocity.normalized()*speed

func redirect_bullet(starting_position: Vector2, position_to_fire_to: Vector2) -> void:
	self.set_starting_position(starting_position)
	self.set_direction_to_position(position_to_fire_to)
	self.look_at(self.position + self.velocity)

func move() -> void:
	move_and_slide()

func _physics_process(_delta) -> void:
	move()

func _process(_delta) -> void:
	self.look_at(self.position + self.velocity)

func setup_hitbox() -> void:
	self.hitbox.entered_hurtbox.connect(_on_hit)
	
func _on_hit(_hurtbox: Hurtbox) -> void:
	self.queue_free()
