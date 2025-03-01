extends CharacterBody2D

var movement_speed: float = 200.0
var movement_target_position: Vector2 = Vector2(60.0,180.0)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func go_to_painting():
	navigation_agent.target_position = Vector2(1002,450)

func teleport(target_loc: Vector2):
	self.global_position = target_loc

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

# The "click" event is a custom input action defined in
# Project > Project Settings > Input Map tab.
func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("click"):
		return
	set_movement_target(get_global_mouse_position())


func _on_door_collider_area_entered(area: Area2D) -> void:
	print('HELP Im a Dog')
	var something = "e" in "abcd"
	print(something)
	Global.goto_scene(area.roomPath)
	var newPos = area.target_pos
	teleport(newPos)
	set_movement_target(newPos)
