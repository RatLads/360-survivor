@tool
extends Control

@export var radius: float = 30.0 : set = set_crosshair_radius
@export var thickness: float = 1.0 : set = set_crosshair_thickness
@export var color: Color = Color.WHITE : set = set_crosshair_color
@export var gap_angle: float = 45.0 : set = set_crosshair_gap_angle
@export var segments: int = 32 : set = set_crosshair_segments
@export var dot_radius: float = 1.0 : set = set_dot_radius
@export var dot_color: Color = Color.WHITE : set = set_dot_color


@export var base_sensitivity: float = 1.0
@export var edge_slow_radius: float = 200.0
@export var min_speed_multiplier: float = 0.2

func _draw():
	draw_circle_crosshair()
	draw_circle(Vector2(0,0),dot_radius, dot_color)

func draw_circle_crosshair():
	var gap_rad = deg_to_rad(gap_angle)
	
	var arc_segments = [
		# Bottom-right quadrant
		[gap_rad / 2, PI / 2 - gap_rad / 2],
		# Bottom-left quadrant
		[PI / 2 + gap_rad / 2, PI - gap_rad / 2],
		# Top-left quadrant
		[PI + gap_rad / 2, 3 * PI / 2 - gap_rad / 2],
		# Top-right quadrant
		[3 * PI / 2 + gap_rad / 2, 2 * PI - gap_rad / 2]
	]
	for arc in arc_segments:
		var start_angle = arc[0]
		var end_angle = arc[1]
		
		var points = []
		var angle_step = (end_angle - start_angle) / segments
		
		for i in range(segments + 1):
			var angle = start_angle + i * angle_step
			var point = Vector2(radius * cos(angle), radius * sin(angle))
			points.append(point)
		
		if points.size() > 1:
			draw_polyline(points, color, thickness, true)


func update_crosshair():
	queue_redraw()


func set_crosshair_radius(new_radius):
	radius = new_radius
	update_crosshair()


func set_crosshair_color(new_color):
	color = new_color
	update_crosshair()


func set_crosshair_thickness(new_thickness):
	thickness = new_thickness
	update_crosshair()


func set_crosshair_gap_angle(new_gap_angle):
	gap_angle = new_gap_angle
	update_crosshair()


func set_crosshair_segments(new_segments):
	segments = new_segments
	update_crosshair()
	
func set_dot_radius(new_dot_radius):
	dot_radius = new_dot_radius
	update_crosshair()
	
func set_dot_color(new_dot_color):
	dot_color = new_dot_color
	update_crosshair()
	

var velocity: Vector2 = Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var mouse_delta: Vector2 = event.relative
		move_reticle(mouse_delta)

func move_reticle(mouse_delta: Vector2) -> void:
	var viewport_size = get_viewport_rect().size

	# Distance to nearest edge
	var dist_x = min(global_position.x, viewport_size.x - global_position.x)
	var dist_y = min(global_position.y, viewport_size.y - global_position.y)
	var dist_to_edge = min(dist_x, dist_y)

	# Slow down near edge
	var t = clamp(dist_to_edge / edge_slow_radius, 0.0, 1.0)
	var speed_multiplier = lerp(min_speed_multiplier, 1.0, t)

	velocity = mouse_delta * base_sensitivity * speed_multiplier
	global_position += velocity

	# Clamp inside viewport
	global_position.x = clamp(global_position.x, 0, viewport_size.x)
	global_position.y = clamp(global_position.y, 0, viewport_size.y)
