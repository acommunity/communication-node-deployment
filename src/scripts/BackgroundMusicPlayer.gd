extends Node
"""
For playing music in scene paste 'BackgroundMusicPlayer.tscn' and this string in godot script in 'func _ready():'

	get_node("BGSound").LoadSound(load(path))

get_node("BGSound").play() - plays the audio from the given position ‘from_position’, in seconds
get_node("BGSound").LoadSound(res) - give music resourse for player and play it.
	res - resourse object, can get with 'load(path)' function. Example: load("res://media/sounds/music.wav")
get_node("BGSound").pause() - stop playing music and set 'from_position'.
	next play will be from this position
press Q for play
press E for pause
"""

var BGAudioPlayer
var from_position = 0

func _ready():
	BGAudioPlayer = get_node("AudioPlayer")

func _process(delta):
	if Input.is_key_pressed(KEY_Q):
		print('Q play')
		play()
	if Input.is_key_pressed(KEY_E):
		print('E pause')
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
	