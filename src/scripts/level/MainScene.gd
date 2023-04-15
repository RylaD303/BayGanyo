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

var path #AStar pathfinding obj

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
	var roomPositions = []
	for room in $Rooms.get_children():
		if randi() % 100 < cullPercent or room.area < minArea:
			room.queue_free()
		else:
			room.freeze_mode = 1
			roomPositions.append(Vector2(room.position.x,room.position.y))
	await get_tree().process_frame
	#generate MST for the rooms
	path = findMST(roomPositions)
	
func findMST(nodes): #Prim's algorithm
	var path = AStar2D.new()
	path.add_point(path.get_available_point_id(),nodes.pop_front())
	while nodes:
		var minDist = INF #min dist to note
		var minPos = null #position of min dist
		var currPos = null #current position
		
		for posID1 in path.get_point_ids():
			var pos1 = path.get_point_position(posID1)
			for pos2 in nodes:
				if pos1.distance_to(pos2) < minDist:
					minDist = pos1.distance_to(pos2)
					minPos = pos2
					currPos = pos1
		var n = path.get_available_point_id()
		path.add_point(n,minPos)
		path.connect_points(path.get_closest_point(currPos),n)
		nodes.erase(minPos)
	return path
		
func _draw():
	for room in $Rooms.get_children():
		draw_rect(Rect2(room.position - room.size, room.size * 2),Color(0, 228, 0), false)
	
	if path:
		for pos in path.get_point_ids():
			for neigh in path.get_point_connections(pos):
				var tempPos = path.get_point_position(pos)
				var tempCon = path.get_point_position(neigh)
				draw_line(Vector2(tempPos.x, tempPos.y), Vector2(tempCon.x, tempCon.y), Color(1,1,0), 5, true)
		
func _process(delta):
	queue_redraw()

#reshuffle the room on press space
func _input(event):
	if event.is_action_pressed('ui_select'):
		for node in $Rooms.get_children():
			node.queue_free()
		path = null
		MakeRooms()
		

	
	


