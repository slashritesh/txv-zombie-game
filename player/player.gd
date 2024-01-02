extends CharacterBody2D

var speed = 300
@export var switchScene : PackedScene

func  _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
	print("Player scene ready on instance with ID:", name)
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		$Camera2D.enabled = true
	else:
		$Camera2D.enabled = false
		
	if name == "1" :
		GameManager.players[1].is_Zombie = true
		print(name,GameManager.players.values())
	
func  _process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		#Make_Zombie.rpc()
		for i in GameManager.players:
			var Player = GameManager.players[i]
			if name == str(Player.id):
				$Label.text = Player.name
			if Player.is_Zombie:
				$Label.text = ""
		$Camera2D.make_current()
		var direction = Input.get_vector("left","right","up","down")
		velocity = direction * speed 
		move_and_slide()
	pass


@rpc("any_peer","call_local")
func Make_Zombie():
	for i in GameManager.players:
			var Player = GameManager.players[i]
			if str(Player.id) == name && Player.is_Zombie == true:
				get_tree().change_scene_to_packed(switchScene)
