extends GutTest

enum directions {RIGHT, LEFT} 
var sprites: AnimatedSprite2D = preload("res://src/test/test_objects/animated_sprite_test.tscn").instantiate()

func test_AnimationControl_initial_direction():
	var player_animation_controller: PlayerAnimationController = autofree(PlayerAnimationController.new())
	assert_eq(player_animation_controller.get_character_direction(), PlayerAnimationController.DEFAULT_DIRECTION)

func test_update_direction():
	var player: Player = autofree(Player.new())
	var animation_controller: PlayerAnimationController = autofree(PlayerAnimationController.new())
	animation_controller.player = player
	#turning left
	player.velocity= Vector2(-1,0)
	animation_controller.update_direction()
	assert_eq(animation_controller.get_character_direction(),directions.LEFT)
	#turning right
	player.velocity= Vector2(1,0)
	animation_controller.update_direction()
	assert_eq(animation_controller.get_character_direction(),directions.RIGHT)
	#staing idle
	player.velocity= Vector2(0,0)
	animation_controller.update_direction()
	assert_eq(animation_controller.get_character_direction(),directions.RIGHT)

func test_start_moving_changes_animation():
	var player: Player = autofree(Player.new())
	var animation_controller: PlayerAnimationController = autofree(PlayerAnimationController.new())
	animation_controller.player = player
	animation_controller.sprite = sprites
	animation_controller.sprite.play(&"idle_right")
	assert_eq(animation_controller.sprite.animation,&"idle_right")
	player.velocity= Vector2(1,0)
	animation_controller.update_sprites()
	assert_eq(animation_controller.sprite.animation,&"walk_right")
	
func test_stop_moving_changes_animation():
	var player: Player = autofree(Player.new())
	var animation_controller: PlayerAnimationController = autofree(PlayerAnimationController.new())
	animation_controller.player = player
	animation_controller.sprite = sprites
	animation_controller.sprite.play(&"walk_right")
	assert_eq(animation_controller.sprite.animation,&"walk_right")
	player.velocity= Vector2(0,0)
	animation_controller.update_sprites()
	assert_eq(animation_controller.sprite.animation,&"idle_right")
	
