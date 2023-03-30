extends Node2D

@onready var bullets = $bullet_field
@onready var player = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("bullet_shot", _on_player_bullet_shot_create_bullet)


func _on_player_bullet_shot_create_bullet(bullet):
	bullets.add_child(bullet)
