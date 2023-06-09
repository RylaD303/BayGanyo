extends GutTest

enum directions {RIGHT, LEFT} 
var sprites: AnimatedSprite2D = preload("res://src/test/test_objects/animated_sprite_test.tscn").instantiate()

func after_all():
	sprites.free()
	assert_no_new_orphans('There is some memory allocated still.')

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
	player.velocity= Vector2.ZERO
	animation_controller.update_direction()
	assert_eq(animation_controller.get_character_direction(),directions.RIGHT)

func test_start_moving_changes_animation():
	var player: Player = autofree(Player.new())
	var animation_controller: PlayerAnimationController = autofree(PlayerAnimationController.new())
	animation_controller.player = player
	animation_controller.sprite = sprites
	animation_controller.sprite.play(&"idle_right")
	player.velocity= Vector2(1,0)
	animation_controller.update_direction()
	animation_controller.update_sprites()
	assert_eq(animation_controller.sprite.animation,&"walk_right")
	
func test_stop_moving_changes_animation():
	var player: Player = autofree(Player.new())
	var animation_controller: PlayerAnimationController = autofree(PlayerAnimationController.new())
	animation_controller.player = player
	animation_controller.sprite = sprites
	player.velocity= Vector2(1,0)
	animation_controller.update_direction()
	animation_controller.update_sprites()
	assert_eq(animation_controller.sprite.animation,&"walk_right")
	player.velocity= Vector2.ZERO
	animation_controller.update_direction()
	animation_controller.update_sprites()
	assert_eq(animation_controller.sprite.animation,&"idle_right")
	
func test_change_sprite_direction(): 
	var player: Player = autofree(Player.new())
	var animation_controller: PlayerAnimationController = autofree(PlayerAnimationController.new())
	animation_controller.player = player
	animation_controller.sprite = sprites
	animation_controller.sprite.play(&"idle_left")
	player.velocity= Vector2(1,0)
	animation_controller.update_direction()
	animation_controller.update_sprites()
	assert_eq(animation_controller.sprite.animation,&"walk_right")
