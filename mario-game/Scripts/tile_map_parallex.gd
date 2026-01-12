extends TileMap

# Parallax speeds (lower = slower, appears further back)
@export var main_bg_speed: float = 0.2
@export var second_bg_speed: float = 0.3
@export var foreground_speed: float = 1

var camera: Camera2D
var main_background: TileMapLayer
var second_background: TileMapLayer
var foreground: TileMapLayer
var initial_positions: Dictionary = {}

func _ready() -> void:
	# Find TileMapLayers - they are children of this TileMap
	for child in get_children():
		if child is TileMapLayer:
			var name_lower = child.name.to_lower()
			print("Found TileMapLayer: ", child.name)
			if "mainbackground" in name_lower:
				main_background = child
				initial_positions["main"] = child.position
				print("  -> Assigned as main background")
			elif "secondbackground" in name_lower:
				second_background = child
				initial_positions["second"] = child.position
				print("  -> Assigned as second background")
			elif "foreground" in name_lower:
				foreground = child
				initial_positions["fore"] = child.position
				print("  -> Assigned as foreground")

func _process(_delta: float) -> void:
	if not camera:
		camera = get_viewport().get_camera_2d()
		if not camera:
			return
	
	var cam_pos = camera.global_position
	
	# Apply parallax offset to each layer
	if main_background:
		main_background.position.x = initial_positions["main"].x - cam_pos.x * (0.3 - main_bg_speed)
	
	if second_background:
		second_background.position.x = initial_positions["second"].x - cam_pos.x * (0.5 - second_bg_speed)
	
	if foreground:
		foreground.position.x = initial_positions["fore"].x - cam_pos.x * (1.0 - foreground_speed)
