extends RigidBody2D

var size
var area

func MakeRoom(_pos, _size):
	position = _pos
	size = _size
	area = size.x * size.y
	var shape = RectangleShape2D.new()
	shape.custom_solver_bias = 0.5
	shape.extents = size
	$CollisionShape2D.set_shape(shape)

	
