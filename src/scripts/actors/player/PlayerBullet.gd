extends Hitbox

var velocity:Vector2 = Vector2(0,1)
var speed: float = 0.0;
const INITIAL_DAMAGE: int = 5 
# Called when the node enters the scene tree for the first time.
func _ready():
	self.damage = INITIAL_DAMAGE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
