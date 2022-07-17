extends Node2D

export var ApproxLoopLength : float = 0.0
export var ExactLoopLength : float = 0.0
export var LoopOffsetCount : int = 0
var LoopStart : float = 0.0
var LoopEnd : float = 0.0
var NumSections : int = 0

func SetExactLoopLength() -> void:
	var fullLength : float = $Track1.get_stream().get_length()
	NumSections = int(fullLength/ApproxLoopLength)
	ExactLoopLength = fullLength / float(NumSections)

func Play() -> void:
	SetExactLoopLength()
	$Track1.play()
	LoopOffsetCount = 0
	LoopStart = 0.0
	LoopEnd = ExactLoopLength

func PlayPause() -> void:
	if $Track1.isPlaying:
		$Track1.pause()
	else:
		$Track1.play()

func Stop() -> void:
	$Track1.stop()

func SkipLoop() -> void:
	if ExactLoopLength > 0 and LoopOffsetCount > 0:
		var p = $Track1
		var position : float = p.get_playback_position()
		var newPos : float = position + ExactLoopLength
		if newPos > p.get_stream().get_length():
			return
		#p.play(position + ExactLoopLength)
		var newLoopStart : float = LoopOffsetCount * ExactLoopLength
		#LoopStart = LoopOffsetCount * ExactLoopLength
		LoopEnd = newLoopStart + ExactLoopLength
	else:
		Play()
	if ExactLoopLength > 0:
		LoopOffsetCount += 1

func _process(_delta: float) -> void:
	if ExactLoopLength > 0:
		var p = $Track1
		var position : float = p.get_playback_position()
		if position > LoopEnd:
			LoopStart = LoopOffsetCount * ExactLoopLength
			p.play(LoopStart)
			if LoopStart == LoopEnd:
				LoopEnd = LoopEnd + ExactLoopLength

