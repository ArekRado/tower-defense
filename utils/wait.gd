class_name Wait

static func seconds(tree: SceneTree, time: float) -> void:
  await tree.create_timer(time).timeout
