extends Node2D

@export var ApproxLoopLength : float = 0.0
@export var ExactLoopLength : float = 0.0
@export var LoopOffsetCount : int = 0

var LoopStart : float = 0.0
var LoopEnd : float = 0.0
var NumSections : int = 0


func SetExactLoopLength() -> void:
	var fullLength : float = $Track1.get_stream().get_length()
	NumSections = int(fullLength/ApproxLoopLength)
	ExactLoopLength = fullLength / float(NumSections)


func reset_pitch() -> void:
	$Track1.pitch_scale = 1


func play(loop_offset : int = -1) -> void:
	SetExactLoopLength()
	if loop_offset == -1:
		$Track1.play()
		LoopOffsetCount = 0
		LoopStart = 0.0
		LoopEnd = ExactLoopLength
	else:
		LoopOffsetCount = loop_offset
		LoopStart = ExactLoopLength * loop_offset
		LoopEnd = LoopStart + ExactLoopLength
		$Track1.play(LoopStart)


func PlayPause() -> void:
	if $Track1.isPlaying:
		$Track1.pause()
	else:
		$Track1.play()


func Stop() -> void:
	$Track1.stop()


func SkipLoop() -> void:
	if ExactLoopLength > 0 and LoopOffsetCount > 0:
		var newLoopStart : float = LoopOffsetCount * ExactLoopLength
		LoopEnd = newLoopStart + ExactLoopLength
	else:
		play()
	if ExactLoopLength > 0:
		LoopOffsetCount += 1


func _process(_delta: float) -> void:
	if ExactLoopLength > 0:
		var p = $Track1
		var playback_pos : float = p.get_playback_position()
		if playback_pos > LoopEnd:
			LoopStart = LoopOffsetCount * ExactLoopLength
			p.play(LoopStart)
			if LoopStart >= LoopEnd:
				LoopEnd = LoopStart + ExactLoopLength


func _on_Track1_finished():
	var p = $Track1
	p.pitch_scale += 0.05
	play(3)
	
	
