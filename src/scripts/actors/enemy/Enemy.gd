extends CharacterBody2D

class_name Enemy 

@export var health_controller : HealthController
@export var hurtbox : Hurtbox

func setup_hurtbox_connections():
	self.hurtbox.hitbox_entered.connect(self._on_hitbox_entered)

func _on_hitbox_entered(hitbox: Hitbox):
	self.health_controller.take_damage(hitbox.get_damage())
	hitbox.entered_hurtbox.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
