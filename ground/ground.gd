extends TileMap
class_name Ground

# ground can have only one height!
var height: float = 69.0

@onready var static_body2D: StaticBody2D = $StaticBody2D

func _ready() -> void:
	var cells: Array[Vector2i] = get_used_cells(0)

	var filtered_cells: Array[Vector2i] = cells.filter(func (cell_position:Vector2i) -> bool: 
		return cells.any(func (cell_position2:Vector2i) -> bool: 
			return cell_position.x == cell_position2.x && cell_position.y + 1 == cell_position2.y
		) == false
	)
	
	for cell_position in filtered_cells:
		var normalized_cell_position: Vector2 = cell_position * tile_set.tile_size
		
		#set_cell(0, cell_position, 4)
		
		var collision_shape2D: CollisionShape2D = CollisionShape2D.new()
		
		var segment_shape2d: SegmentShape2D = SegmentShape2D.new()
		segment_shape2d.a = normalized_cell_position + Vector2(0, tile_set.tile_size.y)
		segment_shape2d.b = normalized_cell_position + Vector2(tile_set.tile_size.x, tile_set.tile_size.y)
		collision_shape2D.shape = segment_shape2d
		
		static_body2D.add_child(collision_shape2D)
		
	#set_cells_terrain_connect(0, filtered_cells, 9, 9)
	#set_cell


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
