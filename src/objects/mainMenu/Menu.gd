extends Control




func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://src/objects/player/player.tscn")
	# here scene must be replaced with the game/firts level scene


func _on_button_options_pressed():
	get_tree().change_scene_to_file("res://src/objects/mainMenu/options_menu.tscn")


func _on_button_quit_pressed():
	get_tree().quit()
