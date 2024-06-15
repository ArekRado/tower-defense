extends TileMap
class_name Ground

# ground can have only one height!
var height: float = 69.0

@onready var static_body2D: StaticBody2D = $StaticBody2D

func _ready() -> void:
	var cells: Array[Vector2i] = get_used_cells(0)

	var bottom_cells: Array[Vector2i] = get_bottom_edges(cells)
	var top_cells: Array[Vector2i] = get_top_edges(cells)
	
	for cell_position in bottom_cells:
		var normalized_cell_position: Vector2 = cell_position * tile_set.tile_size
		
		var collision_shape2D: CollisionShape2D = CollisionShape2D.new()
		
		var segment_shape2d: SegmentShape2D = SegmentShape2D.new()
		var segment_position: Array[Vector2] = get_bottom_edge_position(normalized_cell_position)
		
		segment_shape2d.a = segment_position[0]
		segment_shape2d.b = segment_position[1]
		
		collision_shape2D.shape = segment_shape2d
		
		static_body2D.add_child(collision_shape2D)

func get_bottom_edges(cells: Array[Vector2i]) -> Array[Vector2i]:
	return cells.filter(func(cell_position: Vector2i) -> bool:
		return cells.any(func(cell_position2: Vector2i) -> bool:
			return cell_position.x == cell_position2.x&&cell_position.y + 1 == cell_position2.y
		) == false
	)

func get_top_edges(cells: Array[Vector2i]) -> Array[Vector2i]:
	return cells.filter(func(cell_position: Vector2i) -> bool:
		return cells.any(func(cell_position2: Vector2i) -> bool:
			return cell_position.x == cell_position2.x&&cell_position.y - 1 == cell_position2.y
		) == false
	)

func get_bottom_edge_position(cell_position: Vector2) -> Array[Vector2]:
	return [cell_position + Vector2(0, tile_set.tile_size.y), cell_position + Vector2(tile_set.tile_size.x, tile_set.tile_size.y)]

func get_top_edge_position(cell_position: Vector2) -> Array[Vector2]:
	return [cell_position + Vector2(0, tile_set.tile_size.y), cell_position + Vector2(tile_set.tile_size.x, tile_set.tile_size.y)]
