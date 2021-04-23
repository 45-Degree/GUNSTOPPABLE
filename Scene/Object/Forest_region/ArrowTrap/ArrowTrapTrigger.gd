extends StaticBody2D

var Trigger = false
export(NodePath) var node_path

func _on_Hurtbox_area_entered(area):
	if Trigger == false:
		print("D")
		var Trap = get_node(node_path)
		Trap.Trigger()
		Trigger = true
