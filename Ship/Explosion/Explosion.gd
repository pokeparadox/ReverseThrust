extends Node2D

func Explode(exploding : bool):
	if not exploding:
		$GPUParticles2D.restart()
		
	$GPUParticles2D.set_emitting(exploding)
	$GPUParticles2D.visible = exploding
	$CpEmitter.emitting = exploding
