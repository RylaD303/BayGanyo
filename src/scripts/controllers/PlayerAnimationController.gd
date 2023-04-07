extends Node

class_name PlayerAnimationController

enum directions {RIGHT, LEFT} 
const DEFAULT_DIRECTION: directions = directions.RIGHT
var _character_direction = directions.RIGHT
@export var player: Player
@export var sprite: AnimatedSprite2D

func get_character_direction()-> directions:
	return _character_direction	
	
func _player_is_moving()-> bool:
	return self.player.velocity.x != 0 || self.player.velocity.y != 0

func update_direction()-> void:
	if(self.player.velocity.x < 0):
		_character_direction = directions.LEFT
	elif(self.player.velocity.x > 0):
		_character_direction = directions.RIGHT
		
func update_sprites()-> void:
	if(_player_is_moving()):
		if(_character_direction == directions.RIGHT):
			self.sprite.play(&"walk_right")
		else:
			self.spite.play(&"walk_left")
	else:
		if(_character_direction == directions.RIGHT):
			self.sprite.play(&"idle_right")
		else:
			self.spite.play(&"idle_left")


