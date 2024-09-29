extends Node
class_name Health

@export var max_value: float
@export var value: float

@onready var progress_bar: ProgressBar = $SubViewport/ProgressBar

func _ready() -> void:
	update_progress_bar()

func update_progress_bar() -> void:
	progress_bar.value = value
	progress_bar.max_value = max_value
