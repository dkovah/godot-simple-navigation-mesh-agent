tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("NavigationMeshAgent","Spatial",preload("snma_node.gd"), preload("icon.png"))
	pass

func _exit_tree():
	remove_custom_type("NavigationMeshAgent")
	pass