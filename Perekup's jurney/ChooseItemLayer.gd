extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _draw():
	var choose_items = get_parent().choose_items
	for i in choose_items.size() :
		var rect : Rect2
		rect = choose_items[i].control_item.get_rect()				
		
		var rect2 = choose_items[i].control_item.get_global_transform()
		rect.position = rect2.origin		
		
		rect.position.x -= 4
		rect.position.y -= 4
		rect.size.x += 4
		rect.size.y += 4
		draw_rect(rect, Color.DARK_GRAY, false)		
	
	if choose_items.size() == 2:
		draw_mid_line_y(choose_items)

func draw_mid_line_y(choose_items):
	var item1 = choose_items[0].control_item
	var item2 = choose_items[1].control_item
	
	if item1.get_global_transform().origin.x > item2.get_global_transform().origin.x :
		item2 = choose_items[0].control_item
		item1 = choose_items[1].control_item
	
	var globalRect1 = item1.get_global_transform()
	var globalRect2 = item2.get_global_transform()
	
	var x1 = item1.get_rect().size.x / 2 + globalRect1.origin.x
	var y1 = item1.get_rect().size.y + globalRect1.origin.y
	
	var midY = (globalRect2.origin.y - y1) / 2
	
#	first line to mid
	draw_line(Vector2(x1, y1), Vector2(x1, y1 + midY), Color.DARK_GRAY)	
	
	var x2 = item2.get_rect().size.x / 2 + globalRect2.origin.x
	var y2 = globalRect2.origin.y

#	second line to mid	
	draw_line(Vector2(x2, y2 - 4), Vector2(x2, y2 - midY), Color.DARK_GRAY)
	
#		var midY = y1;
	draw_line(Vector2(x1, y1 + midY), Vector2(x2, y2 - midY), Color.DARK_GRAY)			

func draw_mid_line_x(choose_items):
	var item1 = choose_items[0].control_item
	var item2 = choose_items[1].control_item
	
	if item1.get_global_transform().origin.x > item2.get_global_transform().origin.x :
		item2 = choose_items[0].control_item
		item1 = choose_items[1].control_item
	
	var globalRect1 = item1.get_global_transform()
	var globalRect2 = item2.get_global_transform()
	
	var x1 = item1.get_rect().size.x + globalRect1.origin.x
	var y1 = item1.get_rect().size.y / 2 + globalRect1.origin.y
	
	var midX = (globalRect2.origin.x - x1) / 2
	
	draw_line(Vector2(x1, y1), Vector2(x1 + midX, y1), Color.DARK_GRAY)	
	
	var x2 = globalRect2.origin.x - 4
	var y2 = item2.get_rect().size.y / 2 + globalRect2.origin.y
	
	draw_line(Vector2(x2, y2), Vector2(x2 - midX + 4, y2), Color.DARK_GRAY)
	
#		var midY = y1;
	draw_line(Vector2(x1 + midX, y1), Vector2(x1 + midX, y2), Color.DARK_GRAY)			
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
