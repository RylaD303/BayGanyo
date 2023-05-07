extends Control

class_name OptionsMenu

func _on_button_back_pressed():
	get_tree().change_scene_to_file("res://src/objects/menu/main_menu.tscn")
