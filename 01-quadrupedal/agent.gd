extends Node3D

@onready var ai_controller: Node3D = $AIController3D

@onready var agent_root: Node3D = $"."
@onready var agent_body: RigidBody3D = $AgentBody
@onready var agent_leg1: RigidBody3D = $AgentLeg1
@onready var agent_leg2: RigidBody3D = $AgentLeg2
@onready var agent_leg3: RigidBody3D = $AgentLeg3
@onready var agent_leg4: RigidBody3D = $AgentLeg4

@onready var agent_body_parts = [
	agent_body,
	agent_leg1,
	agent_leg2,
	agent_leg3,
	agent_leg4
]

var initial_transforms = {}
var target_counter = 0

func _ready() -> void:
	for part in agent_body_parts:
		initial_transforms[part.name] = part.global_transform
	

func _process(_delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("manual_reset"):
	#	reset_sim()

func _physics_process(_delta: float) -> void:
	agent_leg1.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg1))
	agent_leg2.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg2))
	agent_leg3.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg3))
	agent_leg4.apply_torque_impulse(Vector3(0, 0, ai_controller.r_leg4))


func _on_target_body_entered(body: Node3D) -> void:
	if body.name == agent_body.name:
		target_counter += 1
		print("Agent has reached target ", target_counter, " times!")
		reset_rigid_bodies()
		ai_controller.reward += 1.0


func _on_wall_body_entered(_body: Node3D) -> void:
	reset_sim()
	ai_controller.reward -= 1.0
	
func _on_floor_area_body_entered(body: Node3D) -> void:
	if body.name == agent_body.name:
		reset_sim()
		ai_controller.reward -= 1.0
		

func reset_sim() -> void:
	reset_rigid_bodies()
	ai_controller.reset()


func reset_rigid_bodies() -> void:
	# print_state("Resetting object...")
	
	# Temporarily freeze all rigid bodies
	for part in agent_body_parts:
		part.freeze = true

	# Reset each body part's transform relative to the root
	for part in agent_body_parts:
		part.global_transform = initial_transforms[part.name]
		part.linear_velocity = Vector3.ZERO
		part.angular_velocity = Vector3.ZERO

	# Allow the physics engine to reapply dynamics after resetting
	#await get_tree().create_timer(1).timeout  # Short delay to stabilize
	for part in agent_body_parts:
		part.freeze = false

	# print_state("Reset completed")

			
			
func print_state(label: String) -> void:
	print(label)
	print(agent_root.position, '@', agent_root.rotation)
	for part in agent_body_parts:
		print(part.position, '@', part.rotation)
