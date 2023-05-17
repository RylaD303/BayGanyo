extends Node2D


class_name Laser

var raycast2d: RayCast2D = RayCast2D.new()
var vfx_line: Line2D = Line2D.new()

func on_ready():
	pass

func reset_line():
	vfx_line.points[1] = Vector2.ZERO

func create_line() -> void:
	vfx_line.points[1] = transform.xform_inv(raycast2d.get_collision_point())
