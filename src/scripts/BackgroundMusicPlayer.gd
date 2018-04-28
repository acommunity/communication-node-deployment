extends Node
"""
You can use this construction in start godot script
		onready var bgsound = get_node("BGSound")
and functions may look like 
		bgsound.play()
		
get_node("BGSound").play(from_position) - plays the audio from the given position ‘from_position’, in seconds
get_node("BGSound").LoadSound(res) - give music resourse for player and play it.
	res - resourse object, can get with 'load(path)' function. Example: load("res://media/sounds/music.wav")
get_node("BGSound").pause() - stop playing music and return playbackPosition.
	next play will be from this position
"""
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var BGAudioPlayer
var from_position = 0

func _ready():
	BGAudioPlayer = get_node("AudioPlayer")

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Input.is_key_pressed(KEY_Q):
		print('Q play')
		play()
	if Input.is_key_pressed(KEY_W):
		print('W pause')
		pause()

func play():
	if !BGAudioPlayer.is_playing():
		BGAudioPlayer.play(from_position)

func LoadSound(res):
	BGAudioPlayer.stream = res
	BGAudioPlayer.play()

func pause():
	BGAudioPlayer.stop()
	from_position = BGAudioPlayer.get_playback_position()
	