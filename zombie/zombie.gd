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
	for onePlayer in get_tree().get_nodes_in_group("playerSpawnPoint"):
		var index = 0
		if onePlayer.name == str(index):
			navigation_agent.target_position = onePlayer.global_position
		index += 1



func _on_timer_timeout():
	make_path()



