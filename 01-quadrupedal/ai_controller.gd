extends AIController3D

var r_leg1 = 0.0
var r_leg2 = 0.0
var r_leg3 = 0.0
var r_leg4 = 0.0

@onready var agent_body: Node3D = $"../Agent/AgentBody"
@onready var leg1: Node3D = $"../Agent/AgentBody/LegJoint1/AgentLeg"
@onready var leg2: Node3D = $"../Agent/AgentBody/LegJoint2/AgentLeg"
@onready var leg3: Node3D = $"../Agent/AgentBody/LegJoint3/AgentLeg"
@onready var leg4: Node3D = $"../Agent/AgentBody/LegJoint4/AgentLeg"

@onready var target: Area3D = $"../Target"

func get_obs() -> Dictionary:
	
	var a_body_pos = agent_body.global_position
	var a_body_rot = agent_body.global_position
	
	var t_pos = target.global_position
	
	var l1_rot = leg1.rotation
	var l2_rot = leg2.rotation
	var l3_rot = leg3.rotation
	var l4_rot = leg4.rotation
	
	var obs := [
		a_body_pos.x, a_body_pos.y, a_body_pos.z,
		a_body_rot.x, a_body_rot.y, a_body_rot.z,
		t_pos.x, t_pos.y, t_pos.z,
		l1_rot.x, l1_rot.y, l1_rot.z,
		l2_rot.x, l2_rot.y, l2_rot.z,
		l3_rot.x, l3_rot.y, l3_rot.z,
		l4_rot.x, l4_rot.y, l4_rot.z
	]
	
	return {"obs": obs}

func get_reward() -> float:	
	return reward
	
func get_action_space() -> Dictionary:
	return {
		"rotate" : {
			"size": 4,
			"action_type": "continuous"
		},
	}
	
func set_action(action) -> void:	
	r_leg1 = action["rotate"][0]
	r_leg2 = action["rotate"][1]
	r_leg3 = action["rotate"][2]
	r_leg4 = action["rotate"][3]
