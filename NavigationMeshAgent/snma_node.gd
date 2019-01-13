extends Spatial

export(NodePath) var navigation setget set_navigation
export(NodePath) var target setget set_target

export var follow = true
export var rotate = true
export var rotation_speed = 0.1

export var accel= 2
export var deaccel= 4
export var max_speed = 20

var look
var vel = Vector3()
var g = -9.8
var evading=false
var to_evade = Vector3()
var navigator

func _ready():
	if target != null:
		target = get_node(target)
	if navigation != null:
		navigation = get_node(navigation)
	
	if not get_parent() is KinematicBody:
		print("The parent must be a KinematicBody")
	
	navigator=get_parent()
	translation = Vector3(0,0,0)
	look = Position3D.new()
	get_tree().current_scene.call_deferred("add_child",look)

func _process(delta):
	var dir = Vector3()
	var follow_target = target.translation
	var navigator_pos = navigator.translation
	var path = navigation.get_simple_path(navigator_pos,follow_target)
	var offset = Vector3()
	
	if len(path) >= 2:
		offset = path[1] - navigator.translation
		offset = offset.normalized()
	else:
		offset=Vector3(0,0,0)
		
	dir = offset
	dir.y = 0
	
	if rotate:
		var to_look = translation+dir
		if look.translation != to_look:
			look.look_at(to_look,Vector3(0,1,0))
		soft_rotate(rotation_speed)
	
	if follow:
		vel.y += delta * g
		var hvel = vel
		hvel.y = 0

		var speed_target = dir * max_speed
		var current_accel
		if (dir.dot(hvel) > 0):
			current_accel = accel
		else:
			current_accel = deaccel

		hvel = hvel.linear_interpolate(speed_target, accel*delta)
		vel.x = hvel.x
		vel.z = hvel.z

		vel = navigator.move_and_slide(vel,Vector3(0,1,0))

func soft_rotate(offset):
	var current = navigator.rotation.y
	var end = look.rotation.y
	var factor=calc_factor(current,end)
	
	if factor > PI:
		if end < 0:
			end += 2 * PI
		if current < 0:
			current += 2*PI
		factor = calc_factor(current,end)
		
	if factor > PI:
		end -= 2 * PI
		factor = calc_factor(current,end)
	if factor > PI:
		current -= 2 * PI
		factor = calc_factor(current,end)
	if factor > PI:
		end += 2 * PI
		factor = calc_factor(current,end)
	if factor > 0.05:
		navigator.rotation.y = current + offset*factor if current<end else current - offset*factor
	pass

func calc_factor(current,end):
	var factor = 0
	if current * end >= 0:
		factor = abs(current - end)
	else:
		factor = abs(abs(current) + abs(end))
	return factor
	
func set_navigation(value):
	navigation = value
	
func set_target(value):
	target = value
