extends Node2D

@export var PlayerScene : PackedScene

func _ready():
	var index = 0
	for i in GameManager.players:
		var currentPlayer = PlayerScene.instantiate()
		add_child(currentPlayer)
		
		for spwan in get_tree().get_nodes_in_group("playerSpawnPoint"):
			if spwan.name == str(index):
				currentPlayer.global_position = spwan.global_position
		index += 1
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
