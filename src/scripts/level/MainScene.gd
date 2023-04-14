extends Node2D

var Room = preload("res://src/objects/level/Room.tscn")
var tileSize = 16 #pixels
var numRooms = 50 
var minSize = 16 #min number of tiles
var maxSize = 60 #max ^
var minArea = 800
var verticalSpread = 100
var horisontalSpread = 200
var cullPercent = 60

func _ready():
	randomize()
	MakeRooms()
	
func MakeRooms():
	for i in range(numRooms):
		var pos = Vector2(randf_range(-horisontalSpread,horisontalSpread), randf_range(-verticalSpread,verticalSpread))
		var room = Room.instantiate()
		var width = minSize + randi() % (maxSize - minSize)
		var heigth = minSize + randi() % (maxSize - minSize)
		room.MakeRoom(pos, Vector2(width, heigth))
		$Rooms.add_child(room)
	#wait for the movement to stop
	await get_tree().create_timer(1).timeout
	#cull rooms
	for room in $Rooms.get_children():
		if randi() % 100 < cullPercent or room.area < minArea:
			room.queue_free()
		else:
			room.freeze_mode = 1
	
		
func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2),Color(32, 228, 0), false)
		
func _process(delta):
	queue_redraw()


#reshuffle the room on press space
func _input(event):
	if event.is_action_pressed('ui_select'):
		for node in $Rooms.get_children():
			node.queue_free()
		MakeRooms()
		

	
	


