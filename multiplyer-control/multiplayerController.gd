extends Control

@export var Address = "127.0.0.1"
@export var Port = 4040
@export var Max_players = 10
var peer


func _ready():
	multiplayer.peer_connected.connect(PlayerConnected)
	multiplayer.peer_disconnected.connect(PlayerDisconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	pass



func _process(_delta):
	pass

#This is called on client side and server side both when Player Disconnected
func PlayerConnected(id):
	print("player connected " + str(id))

#This is called on client side and server side both when Player Disconnected
func PlayerDisconnected(id): 
	print("player disconnected " + str(id))

#called only from client : to send info from client to server
func connected_to_server():
	print("Connected to server!")
	SendPlayerInformation.rpc_id(1,$playername.text,multiplayer.get_unique_id())


#called only from client
func connection_failed():
	print("Connection Failed!")

@rpc("any_peer")
func SendPlayerInformation(name,id):
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name" : name,
			"id": id,
			"is_Zombie" : false
		}
	
	if multiplayer.is_server():
		for i in GameManager.players:
			SendPlayerInformation.rpc(GameManager.players[i].name,i)
	#print("send info",name,id)
	pass

@rpc("any_peer","call_local")
func StartGame():
	var Scene = load("res://level/level.tscn").instantiate()
	get_tree().root.add_child(Scene)
	self.hide()
	print("starting game")
	pass

#--------------------------------------

func _on_host_button_down():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(Port,Max_players)
	if error != OK:
		print("Unable to host : "+ error)
		return
	
	#for getting more bandwidth and less load on cpu
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	#setting up peer multiplayer 
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players...")
	SendPlayerInformation($playername.text, multiplayer.get_unique_id())
	pass

func _on_join_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(Address,Port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	pass



func _on_start_game_button_down():
	StartGame.rpc()
	pass 
