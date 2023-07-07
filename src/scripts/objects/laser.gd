extends RayCast2D


class_name Laser

var tween: Tween = Tween.new()
var vfx_line: Line2D = Line2D.new()
var is_casting = false

func _ready():
	set_physics_process(false)
	vfx_line.points[1] = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var cast_point = 0
	self.force_raycast_update()
	if self.is_colliding():
		cast_point =  to_local(self.get_collision_point())

	self.vfx_line.points[1] = cast_point


func set_is_casting(cast: bool):
	self.is_casting = cast
	
	if is_casting:
		self.appear()
	else:
		self.dissapear()
	set_physics_process(is_casting)

func appear() -> void:
	self.tween.stop_all()
	self.tween.interpolate_property(self.vfx_line, "width", 0, 10.0, 0.2)
	self.tween.start()

func dissapear() -> void:
	self.tween.stop_all()
	self.tween.interpolate_property(self.vfx_line, "width", 10.0, 0, 0.1)
	self.tween.start()
