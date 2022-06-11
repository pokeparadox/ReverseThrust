extends Node2D

export var LoopLength : float = 0.0
export var LoopOffsetCount : int = 0
var LoopStart : float = 0.0
var LoopEnd : float = 0.0

func Play() -> void:
	$Track1.play()
	LoopOffsetCount = 0
	LoopStart = 0.0
	LoopEnd = LoopLength

func PlayPause() -> void:
	if $Track1.isPlaying:
		$Track1.pause()
	else:
		$Track1.play()

func Stop() -> void:
	$Track1.stop()

func SkipLoop() -> void:
	if LoopLength > 0 and LoopOffsetCount > 0:
		var p = $Track1
		var position : float = p.get_playback_position()
		var newPos : float = position + LoopLength
		if newPos > p.get_stream().get_length():
			return
		p.play(position + LoopLength)
		LoopStart = LoopOffsetCount * LoopLength
		LoopEnd = LoopStart + LoopLength
	else:
		Play()
	if LoopLength > 0:
		LoopOffsetCount += 1

func _physics_process(_delta: float) -> void:
	if LoopLength > 0:
		var p = $Track1
		var position : float = p.get_playback_position()
		if position > LoopEnd:
			p.play(LoopStart)

