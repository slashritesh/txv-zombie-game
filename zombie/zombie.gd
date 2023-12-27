extends CharacterBody2D

const speed = 300
@onready var navigation_agent := $NavigationAgent2D as NavigationAgent2D
@onready var current_player 

func _ready():
	$Timer.start()
	pass

func _physics_process(_delta: float):
	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()

func make_path():
	var _allplayers = get_tree().get_nodes_in_group("playerSpawnPoint")
	
	


func _on_timer_timeout():
	make_path()



